extends TileMap

class_name ForAstar

class ItsAstar:
	extends AStar2D
	
	func _compute_cost(from_id, to_id):
		return abs(from_id - to_id*2)

var path: PoolVector2Array
var empty_path: PoolVector2Array = []
onready var used_cells = get_used_cells()

var astar = ItsAstar.new()

func _ready():
	add_and_connect()

func add_points():
	for cell in used_cells:
		astar.add_point(szudzik_pair_improved(cell), cell)

func add_this_point(cell):
	if astar.has_point(szudzik_pair_improved(cell)):
			return
	astar.add_point(szudzik_pair_improved(cell), cell)
	call_deferred("connect_points")


func connect_points():
	for cell in used_cells:
		var neighbour_cells := [Vector2.DOWN, Vector2.LEFT, Vector2.RIGHT, Vector2.UP]
		for neighbour_cell in neighbour_cells:
			var next_cell = neighbour_cell + cell
			if used_cells.has(next_cell):
				astar.connect_points(szudzik_pair_improved(cell), szudzik_pair_improved(next_cell), false) 

func get_points(cell): #Debug
	return astar.get_point_weight_scale(szudzik_pair_improved(cell))

func set_weight_for_cells(cell: Vector2, weight: float):
	astar.set_point_weight_scale(szudzik_pair_improved(cell), weight)

func enable_points(cell: Vector2):
	astar.set_point_disabled(szudzik_pair_improved(cell), false)

func disable_points(cell: Vector2):
	if !astar.has_point(szudzik_pair_improved(cell)):
		return
	astar.set_point_disabled(szudzik_pair_improved(cell), true)

func add_and_connect():
	add_points()
	connect_points()

func astar_get_path(start: Vector2, end: Vector2) -> PoolVector2Array:
	if !used_cells.has(start) or !used_cells.has(end):
		return empty_path
	path = astar.get_point_path(szudzik_pair_improved(start), szudzik_pair_improved(end))
	if !path.empty():
		path.remove(0)
	return path

func szudzik_pair_improved(cell_point: Vector2) -> int:
	var a = cell_point.x
	var b = cell_point.y
	if cell_point.x >= 0:
		a = cell_point.x * 2
	else: 
		a = (cell_point.x * -2) - 1
	if cell_point.y >= 0: 
		b = cell_point.y * 2
	else: 
		b = (cell_point.y * -2) - 1	
	var c = szudzik_pair(a,b)
	if a >= 0 and b < 0 or b >= 0 and a < 0:
		return -c - 1
	return c
	
func szudzik_pair(a:int, b:int) -> int:
	if a >= b: 
		return (a * a) + a + b
	else: 
		return (b * b) + a
