extends ChooseCellCard

var phantom: PackedScene
var mouse_pos: Vector2
var temp_phantom

func _ready():
	phantom = load("res://Tools/Phantom.tscn")

func execute(player: Entity, manage_card: FuncRef):
	var new_phantom = phantom.instance()
	new_phantom.player = player
	new_phantom.global_position = mouse_pos
	get_tree().root.add_child(new_phantom)
	new_phantom.init()
	.execute(player, manage_card)

func describe_new(parameters: Node):
	yield(get_tree(), "idle_frame")
	temp_phantom = phantom.instance()
	parameters.params["[duration]"] = temp_phantom.duration
	temp_phantom.queue_free()

func choosing_execute(new_pos: Vector2):
	if grid.used_cells.has(new_pos):
		mouse_pos = grid.map_to_world(new_pos)
		.choosing_execute(new_pos)
