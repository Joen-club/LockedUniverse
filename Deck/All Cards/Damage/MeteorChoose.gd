extends ChooseCellCard

export var random_meteor: PoolVector2Array
var mouse_pos: Vector2
onready var random_meteor_timer = $Random_Meteor
export var card_preview: PackedScene

func _ready():
	set_process_input(false)

func _input(_event):
	var new_mouse_pos = grid.world_to_map(grid.get_global_mouse_position())
	mouse_move(new_mouse_pos)

func cast_random_meteor():
	var cell = grid.used_cells[randi() % grid.used_cells.size()]
	print(cell)
	for i in random_meteor:
		create_execution_areas(cell, i)

func mouse_move(new_mouse_pos: Vector2):
	if new_mouse_pos == mouse_pos:
		return
	
	for prev in get_tree().get_nodes_in_group("CardPreview"):
		prev.queue_free()
	mouse_pos = new_mouse_pos
	for i in activate_cells:
		var cell = mouse_pos + i
		var new_preview = card_preview.instance()
		new_preview.global_position = grid.map_to_world(cell)
		new_preview.add_to_group("CardPreview")
		get_tree().root.add_child(new_preview)

func execute(_player: Entity, managing_card: FuncRef):
	for n in activate_cells:
		create_execution_areas(mouse_pos, n)
	random_meteor_timer.start()
	managing_card.call_func(self)

func create_execution_areas(where_to: Vector2, new_pos: Vector2):
	var cell = where_to + new_pos
	var area = card_execution.instance()
	area.global_position = grid.map_to_world(cell)
	area.my_owner = self
	get_tree().root.add_child(area)

func executed(receiver: Entity):
	receiver.health += actual_value

func opt_function():
	set_process_input(true)

func choosing_execute(this_mouse_pos: Vector2):
	if grid.used_cells.has(this_mouse_pos):
		.choosing_execute(this_mouse_pos)
	for prev in get_tree().get_nodes_in_group("CardPreview"):
		prev.queue_free()
	set_process_input(false)

func _on_Timer_timeout():
	cast_random_meteor()
