extends TileMap

var center: Vector2 = get_used_cells_by_id(1).front()

func draft_the_sketch(blueprint_cells: PoolVector2Array, extended_area: Array):
	var x: int
	var y: int
#	var index: int

	for cell in blueprint_cells:

		if abs(cell.x) <= 3:
			if abs(cell.y) <=3:
				x = cell.x + center.x
				y = cell.y + center.y
				set_cell(x,y, 0)

	while not extended_area.empty():
		var k = extended_area.pop_front()
		match k:
			"Right":
				set_cell(int(center.x)+3, int(center.y), 5)
			"Up":
				set_cell(int(center.x), int(center.y)-3, 9)
			"Left":
				set_cell(int(center.x)-3, int(center.y), 2)
			"Down":
				set_cell(int(center.x), int(center.y)+3, 4)
			"D_Right_Up":
				set_cell(int(center.x)+3, int(center.y)-3, 8)
			"D_Right_Down":
				set_cell(int(center.x)+3, int(center.y)+3, 6)
			"D_Left_Down":
				set_cell(int(center.x)-3, int(center.y)+3, 3)
			"D_Left_Up":
				set_cell(int(center.x)-3, int(center.y)-3, 7)
			
func clean():
	var cells_to_clean = get_used_cells_by_id(0)
	for cell in cells_to_clean:
		set_cell(cell.x, cell.y, -1)
		
	cells_to_clean.clear()
