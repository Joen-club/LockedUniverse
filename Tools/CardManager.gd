extends Node

var deck: Node2D
var deck_manager: Node2D

func put_cards_in_hand(hand: Dictionary, relic_effected: int):
	if relic_effected != 0:
		test_cards_put(hand, relic_effected)
	else: test_cards_put(hand)

func test_cards_put(hand: Dictionary, amount: int = 999):
	for card in hand.keys():
		if hand[card] == null:
			var next_card = deck.all_cards.pop_front()
			if next_card == null:
				yield(deck_manager.return_cards_in_deck(), "completed")
				next_card = deck.all_cards.pop_front()
			yield(get_tree().create_timer(0.4), "timeout")
			hand[card] = next_card
			next_card.global_position = card
			next_card.in_hand = true
			amount -= 1
			if amount <= 0: break

func discard_all_cards(hand: Dictionary):
	for card in hand.keys():
		if hand[card] != null:
			deck_manager.card_discarded(hand[card])
			hand[card] = null
	deck_manager.return_cards_in_deck()
