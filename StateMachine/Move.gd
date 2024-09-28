extends State

var moving: bool = false

func _ready():
	pass

func input(event, cell: Vector2):
	if event.is_action_pressed("Left_click"):#is_action_pressed("Left_click"):
		if moving == true or my_owner.turns_remain <= 0 or !grid.used_cells.has(cell):
			return
		var player_pos = grid.world_to_map(my_owner.global_position)
		var destination = grid.astar_get_path(player_pos, cell)
		if destination.empty():
			return
		move()

func enter_state(_opt_condition=null):
	pass

func move():
	moving = true
	var move_count: int  = 0
	grid.highlighted_cells.clear()
	for my_path in grid.path:
		my_owner.global_position = grid.map_to_world(my_path)
		yield(get_tree().create_timer(0.12), "timeout")
		move_count += 1
		if move_count >= my_owner.turns_remain:
			break
	my_owner.turns_remain -= move_count
	moving = false
