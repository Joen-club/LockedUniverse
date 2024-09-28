extends CardsGrid

##This Node shows all the cards in deck at a current battle.

##When the button "Cards" (The one of the left) is pressed, this function activates
##Creating a grid of cards. Since it's only for a current battle, it won't show 
##Exhausted* cards (see line 12).   *The ones that have 1 activation per battle
func create_grid(count: int = 0):
	print("Count = ", count)
	.create_grid(count)
	for i in columns:
		for k in rows:
			var card = deck.all_cards[my_count] if my_count < deck.all_cards.size() and !deck.all_cards[my_count].additional_features.exhausted else null
			my_count += 1 
			if card is Card and card != null:
				card.global_position = Vector2(130, 30) + Vector2(180*i, 230*k)
				shown_cards.append(card)
	.check_grid_size()
