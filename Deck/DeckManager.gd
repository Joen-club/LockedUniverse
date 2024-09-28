extends Node2D

export var deck_path: NodePath
export var discard_pile_path: NodePath
export var card_manager_path: NodePath

onready var deck = get_node(deck_path)
onready var discard_pile = get_node(discard_pile_path)
onready var card_manager = get_node(card_manager_path)

var hand: Dictionary = {
	Vector2(966, 16): null,
	Vector2(966, 254): null,
	Vector2(966, 506): null
}

var player: Entity
signal relic_effect

func _ready():
	randomize()
	deck.card_execution_nofifier = funcref(self, "manage_card")
	card_manager.deck = deck
	card_manager.deck_manager = self

func define_player(source: Entity):
	player = source
	deck.player = source

func scene_transition():
	card_manager.discard_all_cards(hand)
#	$CanvasLayer/All_cards.visible = false

func return_cards_in_hand():
	for card in discard_pile.cards:
		card.global_position = discard_pile.global_position
	for card in hand.keys():
		if hand[card] != null:
			hand[card].global_position = card

func put_cards_in_hand(relic_effected: int = 0):
	yield(get_tree(), "idle_frame")
	card_manager.put_cards_in_hand(hand, relic_effected)

func manage_card(card: Card):
	for i in hand.keys():
		if hand[i] == card:
			hand[i] = null
	
	card_discarded(card)
	emit_signal("relic_effect", self)

func card_discarded(card: Card):
	if card.additional_features.features["exhaust"]:
		card.global_position = Vector2(10000,10000)
		card.additional_features.exhausted = true
	else:
		discard_pile.cards.append(card)
		card.global_position = discard_pile.position

	card.in_hand = false

func return_cards_in_deck():
	yield(get_tree(), "idle_frame")
	for discarded_card in discard_pile.cards:
		deck.all_cards.append(discarded_card)
		discarded_card.global_position = deck.position
	discard_pile.cards.clear()
	deck.shuffle_cards()

