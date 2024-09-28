extends RelicClass

onready var debuff = $Effect

func init():
	owner_to_influence = get_tree().get_nodes_in_group("Player").front()

func execute(caller):
	var count = 0
	for i in caller.hand.keys():
		if caller.hand[i] == null:
			count += 1
			if count >= 3 and owner_to_influence.turns_remain > 0:
				my_owner.put_cards_in_hand(1)
				debuff.effect(owner_to_influence)
