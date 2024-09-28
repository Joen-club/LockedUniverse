extends ChooseCellCard

var number_of_cells
var cells_to_choose: Array 
export var used_cells: Array 
var cell_chosen: Vector2

func clear():
	grid.card_cells.clear()
	used_cells.clear()

func update_params():
	.update_params()
	number_of_cells = parameters.params["[number_of_cells]"]

func describe(description: Dictionary):
	.describe(description)
	description["[TP_number]"] = number_of_cells

func execute(_player: Entity, managing_card: FuncRef):
	player.global_position = grid.map_to_world(cell_chosen)
	cells_to_choose.clear()
	managing_card.call_func(self)

func choosing_execute(chosen_cell: Vector2):
	cell_chosen = chosen_cell
	clear()
	if cells_to_choose.has(cell_chosen):
		.choosing_execute(chosen_cell)

func opt_function():
	if !cells_to_choose.empty() and grid.card_cells.empty():
		grid.card_cells.append_array(cells_to_choose)
		return
	used_cells.append_array(grid.used_cells)
	used_cells.shuffle()
	for cell in number_of_cells:
		var random_cell = used_cells.pop_front()
		while grid.excluded_cells.has(random_cell):
			random_cell = used_cells.pop_front()
		print(random_cell)
		cells_to_choose.append(random_cell)
		grid.card_cells.append(random_cell)
		grid.set_cell(random_cell.x, random_cell.y, -1)
