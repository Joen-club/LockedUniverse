extends CardsGrid

func create_grid(count: int = 0):
	.create_grid(count)
	for i in columns:
		for k in rows:
			var card = deck.cards[my_count] if my_count < deck.cards.size() else null
			my_count += 1
			if card is Card and card != null:
				card.global_position = Vector2(130, 30) + Vector2(180*i, 230*k)
				shown_cards.append(card)
	.check_grid_size()
