extends Node2D

var active: bool = true
var tier: int = -1
export var level: int = 1

var my_visible: bool setget set_visibility #use this var to change visibility
var scene_transition: bool = false

signal scene_transit

func _ready():
	GameManager.connect("map_toggled", self, "_on_Map_pressed")
	propagate_call("define_map", [self, level])
	var first_child = get_child(0)
	first_child.active = true
	active = false
	for map_node in get_children():
		if map_node is Area2D:
			map_node.tier += tier+1
			map_node.define_tier()

func set_visibility(value):
	visible = value
	get_tree().paused = value

func transit(world_path: String, world_type: String):
	printt(world_type, world_path)
	var encounter: bool
	match world_type:
		"Encounter":
			encounter = true
			self.my_visible = false
		"Shop":
			encounter = false
			visible = false
		"Event":
			encounter = false
			visible = false
			print("Event")
	emit_signal("scene_transit", world_path, encounter)

func _on_Close_pressed():
	self.my_visible = false

func _on_Map_pressed():
	self.my_visible = true
