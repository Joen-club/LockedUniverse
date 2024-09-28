extends Node

onready var green = $Green
export onready var red = $Red
onready var blue = $Blue

export var character: String
var cards_capacity: int = 3

# warning-ignore:unused_signal
signal card_chosen(card)

func _ready():
	randomize()
#	add_card()

func add_card(for_shop: bool = false):
	match character:
		"Red":
			return red.create_cards_list(for_shop)
		"Blue":
			return blue.create_cards_list(for_shop)
		"Green":
			return green.create_cards_list(for_shop)

func load_cards() -> Array:
	match character:
		"Red":
			return red.cards_basic
		"Blue":
			return blue.cards_basic
		"Green":
			return green.cards_basic
	return []
