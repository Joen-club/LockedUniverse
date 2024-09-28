extends ForAstar

class_name Pathfinding

"""Unnecessary
#var GridSize = 8
#var Dic = {}
"""

onready var blocked_cells = $BlockedCells

var highlighted_cells: Array = []
var excluded_cells: Array# = get_used_cells_by_id(4)
var enemies_cells: Array = [] #Necessary so a player wouldn't be able to delete/create
#cells at enemies' positions
var card_cells: Array = [] #For occasion situations

export var cell_spawn_rate: int = 1
export var level_grid_size: Vector2
var cell_turn: int = 0

func _ready():
	call_deferred("define_cells")
	call_deferred("add_and_connect")

func define_cells():
	excluded_cells.clear()
	excluded_cells = blocked_cells.get_used_cells()
	for cell in excluded_cells:
		if used_cells.has(cell):
			disable_points(cell)

func _input(event):
	var tile = world_to_map(get_global_mouse_position())

	if event is InputEventMouseMotion:
		for i in used_cells:
			if !highlighted_cells.has(i) and not card_cells.has(i):
				set_cell(i.x, i.y, 0, false, false, false, Vector2(0,0))
			elif highlighted_cells.has(i) and not card_cells.has(i):
				set_cell(i.x, i.y, 1, false, false, false, Vector2(0,0))
			elif card_cells.has(i):
				set_cell(i.x, i.y, -1, false, false, false, Vector2(0,0))
		if used_cells.has(tile):
			set_cell(tile.x, tile.y, 2, false, false, false, Vector2(0,0))

func check(): #Debug
	for i in used_cells:
		if get_points(i) > 1.0:
			set_cell(i.x, i.y, -1)

func spawn_cell(amount_of_cells):
	#Disable spawn parameter?
	if used_cells.size()>((level_grid_size.x)*(level_grid_size.y+1)): return
	if cell_turn < cell_spawn_rate:
		cell_turn += 1
		return
	while amount_of_cells > 0:
		var new_cell = pick_random_cell()
		while used_cells.has(new_cell):
			new_cell = pick_random_cell()

		cell_turn = 0
		amount_of_cells -= 1
		setting_new_cell(new_cell.x, new_cell.y, new_cell)

func pick_random_cell() -> Vector2:
	var cell_x = randi() % int(level_grid_size.x)
	var cell_y = randi() % int(level_grid_size.y)
	var new_cell = Vector2(cell_x, cell_y)
	return new_cell

func setting_new_cell(x: int, y: int, new_cell: Vector2):
	used_cells.append(new_cell)
	set_cell(x, y, 0, false, false, false, Vector2(0,0))
	add_this_point(new_cell)
	enable_points(new_cell)

"""Unnecessary
#func set_id(cell_point:Vector2) -> int:
#	var a = cell_point.x
#	var b = cell_point.y
#	var c = (a+b)+(a+b+1)/2+b
#	return c
"""

