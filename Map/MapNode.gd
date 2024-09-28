extends Area2D

var map: Node2D
var level: int

export var world_node: String
export var tier: int
export var worlds: Dictionary
export var active: bool
export var used: bool

onready var sprite = $Sprite
onready var my_parent = get_parent()

func _ready():
	randomize()

func _draw():
	for child in get_children():
		if child is Area2D:
			if (self.used and child.active) or (self.used and child.used):
				draw_line(Vector2.ZERO, child.position, Color(0,0,0), 2.5)
			else:
				draw_line(Vector2.ZERO, child.position, Color(1,1,1), 2.5)
	
func _on_MapNode_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.is_pressed():
		if my_parent.active and map.scene_transition:
			map.scene_transition = false
			map.propagate_call("update")
			my_parent.active = false
			my_parent.used = true
			self.active = true
			map.transit(world_node, worlds[world_node])

func define_map(new_map: Node2D, new_level:int):
	level = new_level
	map = new_map

func define_tier():
	for map_node in get_children():
		if map_node is Area2D:
			map_node.tier += tier+1
			map_node.define_tier()
	var directory_path = "res://Worlds/Tiers/"+str(level)+"-"+str(self.tier)+"/"
	var directory = Directory.new()
	if directory.open(directory_path) == OK:
		directory.list_dir_begin()
		var file_name = directory.get_next()
		while file_name != "":
			if directory.current_is_dir() == false:
				worlds[directory_path + file_name] = "Encounter"
			file_name = directory.get_next()
	set_node()

func set_node():
	if worlds.size() == 0:
		return
	var new_node = worlds.keys()[randi()%worlds.size()]
	match worlds[new_node]:
		"Source":
			$Sprite.modulate = Color(2,2,2)
			print("WJWH")
		"Encounter":
			$Sprite.modulate = Color(20,20,20)
		"Shop":
			$Sprite.modulate = Color(0,0,0)
		"Event":
			$Sprite.modulate = Color(1,1,1)
	world_node = new_node
#	yield(get_tree(), "idle_frame")
#	worlds.clear()
