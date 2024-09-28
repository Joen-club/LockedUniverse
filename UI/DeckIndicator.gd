extends Control

var deck: Node2D
var player: Entity

func _ready():
	player = get_tree().get_nodes_in_group("Player").front()
	deck = player.deck

func fill_deck():
	for card in deck.get_children():
		if card is Card:
			card.duplicate()
			pass
