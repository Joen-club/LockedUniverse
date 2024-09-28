extends CanvasLayer

export var player_state_tracker_path: NodePath

onready var player_state_tracker = get_node(player_state_tracker_path)

func show_new_state(new_state_name: String):
	player_state_tracker.text = new_state_name

func scene_transition():
	visible = false

func encounter():
	visible = true
