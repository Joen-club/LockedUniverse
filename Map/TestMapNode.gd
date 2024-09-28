extends TextureRect

export var tier: int
export var worlds: Array
export var active: bool
export var used: bool
onready var my_parent = get_parent()
var map: Control
onready var drew_line = $Line2D
var points: Array

func _ready():
	yield(get_tree(), "idle_frame")
	for child in get_children():
		if child is TextureRect:
			points.push_back(Vector2(16,16))
			points.push_back(child.get_position() + Vector2(16,16))
			drew_line.points = points
			print(drew_line.points)
			if (self.used and child.active) or (self.used and child.used):
				drew_line.default_color = Color(1,1,1)
			else:
				drew_line.default_color = Color(0,0,0)

func define_map(new_map: Control):
	map = new_map

func define_tier():
	for map_node in get_children():
		if map_node is TextureRect:
			map_node.tier += tier+1
			map_node.define_tier()
	var directory_path = "res://Worlds/Tiers/1-"+str(self.tier)+"/"
	var directory = Directory.new()
	if directory.open(directory_path) == OK:
		directory.list_dir_begin()
		var file_name = directory.get_next()
		while file_name != "":
			if directory.current_is_dir() == false:
				worlds.append(directory_path + file_name)
			file_name = directory.get_next()

func _on_Button_pressed():
	if my_parent.active:
			map.propagate_call("update_me")
			my_parent.active = false
			my_parent.used = true
			self.active = true
			print("Now I'm active")

func update_me():
	for child in get_children():
		if child is TextureRect:
			if (self.used and child.active) or (self.used and child.used):
				drew_line.default_color = Color(1,1,1)
#			else:
#				drew_line.default_color = Color(0,0,0)
