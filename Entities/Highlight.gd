extends Node

var grid: Pathfinding
var player: Entity

func define_grid(new_grid: Pathfinding):
	grid = new_grid

func highlight():
	grid.highlighted_cells.clear()
	var player_position = grid.world_to_map(player.global_position)
	for cell in grid.used_cells:
		var highlight = grid.astar_get_path(player_position, cell)
		if highlight.size() > 0 and highlight.size() <= player.turns_remain:
			grid.highlighted_cells.append(cell)
			grid.set_cell(cell.x, cell.y, 1)
