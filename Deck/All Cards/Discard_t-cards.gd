extends Card

var deck_manager: Node2D

func _ready():
	deck_manager = get_tree().get_nodes_in_group("DeckManager").front()

func execute(_player: Entity, manage_card: FuncRef):
	var deck = deck_manager.deck
	for card in deck.get_children():
		if card.is_in_group("t-cards") and !deck_manager.discard_pile.cards.has(card):
			if deck.all_cards.has(card):
				deck.all_cards.erase(card)
			if deck_manager.hand.values().has(card):
				for i in deck_manager.hand:
					if deck_manager.hand[i] == card:
						deck_manager.hand[i] = null
			deck_manager.card_discarded(card)
	manage_card.call_func(self)
