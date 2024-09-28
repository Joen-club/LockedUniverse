extends State

var card: Card

func enter_state(new_card: Card=null):
	self.card = new_card
	print(card)

func input(event):
	if event.is_action_pressed("Test"): #Debug
		emit_signal("state_transition", "Move")
	if event.is_action_pressed("Left_click"):
		execute_card()

func execute_card():
	if card == null:
		print(card)
		breakpoint
	for i in card.activate_cells:
		var cell = grid.world_to_map(my_owner.global_position) + i
		if !grid.used_cells.has(cell):
			continue
		var area = card.card_execution.instance()
		area.global_position = grid.map_to_world(cell)
		area.card_owner = card
		add_child(area)
	card = null
	emit_signal("state_transition", "Move")
