extends State

var card: Card

func enter_state(card_executer = null):
	card = card_executer

func input(event, cell):
	if event is InputEventMouseButton and event.is_pressed():
		card.choosing_execute(cell)
		emit_signal("state_transition", "Move")
		
