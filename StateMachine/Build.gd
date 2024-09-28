extends State

signal relic_effect

func input(event, cell):
	if event.is_action_pressed("Right_click"):
		if cell == grid.world_to_map(my_owner.global_position) or grid.excluded_cells.has(cell) or grid.enemies_cells.has(cell):
			return

		create_or_delete_tiles(cell)

func create_or_delete_tiles(cell):
	if my_owner.turns_remain <= 0:
		return
	if grid.used_cells.has(cell):
		grid.set_cell(cell.x, cell.y, -1, false, false, false, Vector2(0,0))

		var old_point = grid.used_cells.find(cell)
		grid.used_cells.remove(old_point)
		grid.disable_points(cell)
		emit_signal("relic_effect", self)

	elif !grid.used_cells.has(cell):
		grid.setting_new_cell(cell.x, cell.y, cell)

	my_owner.turns_remain -= 1
