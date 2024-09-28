extends AdditionalState

export var additional_effect_path: NodePath #Effect (path)
onready var additional_effect: Node = get_node_or_null(additional_effect_path)
export var gain_energy: bool = false

""" Maybe I should make a PackedScene Effect that would instantiate along
with this script instead of initializing it manually
There are only three parameters: Current effect as a Packed scene (which means
that I will need to get it here as a packed scene as well), Effect Duration
and Effect Description (don't even remember how this one works')"""

func init():
	.init()
	if additional_effect == null:
		print_debug("Set effect")
		additional_effect = get_node(additional_effect_path)
#		breakpoint

func new_action(my_owner: Entity):
	if gain_energy:
		.new_action(my_owner)
	additional_effect.effect(my_owner.player)
