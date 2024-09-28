extends Control

#For now it's just a small part of a shop.

onready var relic_grid = $RelicGrid
onready var card_grid = $CardGrid
var cards: Dictionary

signal scene_transit

func _ready():
	exhibit_card()
	var count:int = 0
	RelicManager.relic_references.shuffle()
	for i in relic_grid.columns:
		if RelicManager.relic_references.empty():
			return
		var k = RelicManager.relic_references[count]
		var new = k.instance()
		new.my_label = k
		count += 1
		relic_grid.add_child(new)

func exhibit_card():
	cards.clear()
	for k in card_grid.columns:
		var new_card_instance = CardManager.add_card(true)
		print(new_card_instance)
		var new_card = new_card_instance.instance()
		cards[new_card.name] = new_card_instance
		var new_card_container = TextureRect.new()
		card_grid.add_child(new_card_container)
		new_card_container.add_child(new_card)
		create_button_for_card(new_card)

func create_button_for_card(new_card):
	var choosing_button = Button.new()
	choosing_button.name = new_card.name
	choosing_button.rect_size = Vector2(147, 210)
	choosing_button.modulate = Color(0,0,0,0)
	choosing_button.connect("pressed", self, "card_chosen", [new_card])
	new_card.add_child(choosing_button)
	new_card.move_child(choosing_button, 3)

func card_chosen(parent):
	if parent.cost > GameManager.currency:
		return
	CardManager.emit_signal("card_chosen", cards[parent.name], true)
	GameManager.currency -= parent.cost
	parent.get_parent().queue_free()

func _on_Leave_pressed():
	emit_signal("scene_transit")
