extends Node

var my_owner
export var relics_features: PoolStringArray

func _ready():
	self.add_to_group("relic_loaders")
	yield(get_tree(), "idle_frame")
	my_owner = get_parent()
