extends EffectClass

var confused_cells: Array

func _ready():
	randomize()

func set_debuff_count(value: int = 0):
	for cell in confused_cells:
		grid.set_weight_for_cells(cell, 1)
	confused_cells.clear()
	.set_debuff_count(value)
	if debuff_count > 0:
		for cell in grid.highlighted_cells:
			var k = randi()%2
			if k == 1:
				grid.set_weight_for_cells(cell, 450)
				confused_cells.append(cell)
	effect_owner.highlight.highlight()
