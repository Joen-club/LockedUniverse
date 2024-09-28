extends Card

class_name ChooseCellCard
var player: Entity

func _ready():
	player = get_tree().get_nodes_in_group("Player").front()

func _on_Area2D_input_event(_viewport, event, _shape_idx):
	if event.is_action_pressed("Left_click"):
		if !in_hand:
			return
		GameManager.emit_signal("change_state", "Choosing", self)
		opt_function()

func opt_function():
	pass

func execute(_player: Entity, managing_card: FuncRef):
	managing_card.call_func(self)

func choosing_execute(_chosen_cell: Vector2):
#	player.turns_remain -= required_energy
	emit_signal("card_executed", self)
