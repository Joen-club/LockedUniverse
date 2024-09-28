extends Control

var active: bool = true
var tier: int

func _ready():
	propagate_call("define_map", [self])
	var first_child = get_child(0)
	first_child.active = true
	active = false
	for map_node in get_children():
		if map_node is TextureRect:
			map_node.tier += tier+1
			map_node.define_tier()
