extends Node

class_name StateMachine

export var state_owner_path: NodePath
export var initial_state_path: NodePath

onready var state_owner

var states: Dictionary = {}
var current_state

func _ready():
	if state_owner_path != "":
		state_owner = get_node(state_owner_path)
