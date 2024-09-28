extends State


var card: Card

func _ready():
#	GameManager.connect("card", self, "on_card")
	pass

func enter_state(new_card: Card=null):
	self.card = new_card
	print(card)

func input(event):
	if event.is_action_pressed("Test"):
		emit_signal("state_transition", "Move")
	if event.is_action_pressed("Left_click"):
		execute_card()
#		var mouse_pos = grid.world_to_map(grid.get_global_mouse_position())
#		var k = get_tree().get_nodes_in_group("Enemies")
#		for i in k:
#			if grid.world_to_map(i.global_position) == mouse_pos:
##				printt(i, "Got Damaged")
#				i.get_damage()

func execute_card():
	if card == null:
		print(card)
		breakpoint
#	if card != null:
#	card.queue_free()
	print(card)
	if card.activate_cells.empty():
		grid.player.health -= card.value
		print(grid.player.health)
	else:
		for i in card.activate_cells:
			var cell = grid.world_to_map(grid.player.global_position) + i
			if !grid.used_cells.has(cell):
				continue
			var area = card.card_execution.instance()
			area.value = card.value
			area.global_position = grid.map_to_world(cell)
			area.card_owner = card
			add_child(area)
#				grid.set_cell(cell.x, cell.y, -1)
#			printt(cell, i)
#				if grid.used_cells.has(i)
#			card.value
	card = null
	emit_signal("state_transition", "Move")
