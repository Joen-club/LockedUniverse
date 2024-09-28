extends Node

var new_cells: PoolVector2Array
var charged: bool
var change_params: FuncRef

func init(card: Card):
	connect_signal(card)
	var temp_array: Array = card.activate_cells
	var max_cell = temp_array.max()
	var min_cell = temp_array.min()
	var new_count = max_cell.x-1
	var min_y = temp_array[0].y
	var max_y = temp_array[0].y
	
	while new_count > min_cell.x:
		for i in temp_array:
			if i.x == new_count:
				if i.y > max_y: max_y = i.y
				if i.y < min_y: min_y = i.y
		while min_y < max_y:
			min_y += 1
			var new_cell = Vector2(new_count, min_y)
			if new_cell == Vector2.ZERO or temp_array.has(new_cell):
				continue
			new_cells.append(new_cell)
		new_count -= 1

func feature(card: Card): 
	if not card is BasicCard:
		print("feature ", self.name, " can't be applied to ", card.name)
		breakpoint
	if charged == true:
		reset_charge(card)
		return
	charged = true
	change_params.call_func(1)
	var k: Array = new_cells
	k.append_array(card.activate_cells)
	card.activate_cells = k
#	card.activate_cells.append_array(new_cells)
	card.blueprint.draft_the_sketch(card.activate_cells, card.extended_area)

func connect_signal(card: Card):
	if card.is_connected("card_executed", self, "reset_charge"):
		return
	card.connect("card_executed", self, "reset_charge")
	
func reset_charge(card: Card):
	if !charged: return
	var temp_array: Array = card.activate_cells
	for new_cell in new_cells:
		if temp_array.has(new_cell):
			temp_array.erase(new_cell)
	card.activate_cells = temp_array
	card.blueprint.clean()
	card.blueprint.draft_the_sketch(card.activate_cells, card.extended_area)
	charged = false
	change_params.call_func(-1)

func change_parameters(what_parent: Card, what_change: int):
	what_parent.parameters.params["[required_energy]"] += what_change
#	what_parent.required_energy += what_change
#	what_parent.describe(what_parent.card_description.key_words)

"""Need to improve a lot. An ability to cancel the charge, increase the cost
of card for charge, clean up"""
