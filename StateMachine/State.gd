extends Node

class_name State

signal state_transition(new_state)
onready var my_owner
export var position_difference: float
var grid: Pathfinding

func _ready():
	pass

func enter_state(_opt_condition=null):
	pass
	
func exit_state():
	pass
