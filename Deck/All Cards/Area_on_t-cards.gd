extends BasicCard

var count: int
var deck_manager: Node2D # *** ?
var actual_activate_cells: Array

"""Для того чтобы подключить деку к нужным картам, можно добавить переменную
в какие-нить доп. фичи ноду карты и включать её когда надо. Дека при добавлении
Карты в колоду чекает эту переменную и либо назначает себя, либо нет"""

func _ready():
	._ready()
	deck_manager = get_tree().get_nodes_in_group("DeckManager").front()

func execute(player: Entity, managing_card: FuncRef):
	set_count()
	.execute(player, managing_card)

func set_count():
	count = 8
	var deck = deck_manager.deck
	for card in deck.get_children():
		if card.is_in_group("t-cards"):
			count += 1
	if count > 0: # *** Why do I even have this? Count is never a negative for now
		get_cells()

func _on_Area2D_mouse_entered(): 
	set_count()
	yield(get_tree(), "idle_frame") # *** ?
	blueprint.preview(actual_activate_cells, grid)

func get_cells():
	actual_activate_cells.clear()
	for cell in activate_cells:
		actual_activate_cells.append(cell)
		count -= 1
		if count <= 0:
			break
