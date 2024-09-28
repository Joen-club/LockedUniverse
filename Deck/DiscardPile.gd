extends Node2D

var cards: Array

func _ready():
	get_cards()

func get_cards():
	for card in get_children():
		cards.append(card)
