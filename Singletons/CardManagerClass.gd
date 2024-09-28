extends Node

class_name CardManagerClass

export var cards: Array #General cards. 100% chance of being on the cards to choose
export var cards_basic: Array #cards that are given to a player at the beginning

export var cards_to_choose: Array #Cards that can be chosen by a player

export var cards_rare: Array #rare cards. Have a chance to be added to the cards to choose
export var cards_epic: Array #epic cards. Have a chance to be added to the cards to choose

onready var card_manager = get_parent() #I know it's not the best practice, but I find it
#More convinient for now, as you don't have to create another for loop in order to assign
#card manager to every child
var cards_options: Dictionary

var positions: PoolVector2Array = [Vector2(260, 200), Vector2(520, 200), Vector2(780, 200)]
#positions for the displayed cards

func create_cards_list(for_shop: bool = false):
	cards_to_choose = cards
	for card in cards_rare:
		var number = rand_range(0.0, 2.0)
		if number >= 0.8:
			cards_to_choose.append(card)
#			var card_to_remove = cards_rare.find(card)
#			cards_rare.remove(card_to_remove)
	for card in cards_epic:
		var number = rand_range(0.0, 2.0)
		if number >= 1.5:
			cards_to_choose.append(card)
#			var card_to_remove = cards_epic.find(card)
#			cards_epic.remove(card_to_remove)
	if for_shop:
		var shop_card = add_cards(for_shop)
		return shop_card
	add_cards()
	

func add_cards(for_shop: bool = false):
	var cards_to_add: int = 0 
	cards_to_choose.shuffle()
	for card_position in positions:
		if cards_to_add >= card_manager.cards_capacity:
			break
		var new_card_instance = cards_to_choose[cards_to_add+1]
		var new_card = new_card_instance.instance()
		cards_options[new_card.name]=new_card_instance
		if for_shop:
			return new_card_instance
		new_card.global_position = card_position
		new_card.z_index = 1
		add_child(new_card)
		cards_to_add += 1 
		create_button_for_card(new_card)

func create_button_for_card(new_card):
	var choosing_button = Button.new()
	choosing_button.name = new_card.name
	choosing_button.rect_size = Vector2(147, 210)
	choosing_button.modulate = Color(0,0,0,0)
	choosing_button.connect("pressed", self, "card_chosen", [new_card.name])
	new_card.add_child(choosing_button)

func card_chosen(parent):
	for card in get_children():
		card.queue_free()
	CardManager.emit_signal("card_chosen", cards_options[parent], true)
	cards_options.clear()
#	cards_to_choose.clear()
