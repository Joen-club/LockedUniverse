extends CanvasLayer

onready var relic_container = $RelicContainer
onready var player: Entity = get_tree().get_nodes_in_group("Player").front()

export var map_path: NodePath
onready var map = get_node(map_path)

func _ready():
	pass

func upload_new_indicator(indicator_name):
	#ALL THE RELICS MUST BE IN THIS FOLDER
	var new_indicator_packed = load("res://Artifacts(and RougeManager)/RelicIndicators/"+indicator_name+".tscn")
	var new_indicator = new_indicator_packed.instance()
	relic_container.add_child(new_indicator)

#func _on_Map_Toggle_pressed():
#	map.my_visible = !map.my_visible
#	GameManager.emit_signal("map_toggled", map.my_visible)
