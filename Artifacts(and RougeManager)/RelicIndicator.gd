extends TextureRect

export var gained: bool setget relic_gained

onready var HUD = get_tree().get_nodes_in_group("HUD").front() #Too lazy for anything more optimized

export var relic_effect: String #This should be exactly the same name as in the RelicManager's
#Dictionary. Depends on what relic you're setting. For the new ones upload the dictionary

var my_label: PackedScene #This is assigned when the sceen instantiated by the shop.gd
#Basically it's for deleting the relic from RelicManager's array

func relic_gained(value):
	gained = value
	if gained:
		RelicManager.relic_and_effects[relic_effect] = true

func _on_Area2D_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.is_pressed() and not gained:
		self.gained = true
		HUD.upload_new_indicator(name)
		var to_delete = RelicManager.relic_references.find(my_label)
		RelicManager.relic_references.remove(to_delete)
		RelicManager.emit_signal("relic_gained", relic_effect)
		call_deferred("queue_free")

func _on_Area2D_mouse_entered():
	$Panel.visible = true

func _on_Area2D_mouse_exited():
	$Panel.visible = false
