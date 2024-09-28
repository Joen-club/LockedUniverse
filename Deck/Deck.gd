extends Node2D

var cards: Array
var all_cards: Array

var card_execution_nofifier: FuncRef
var player: Entity
#var chance_to_execute: bool = true

func _ready():
	randomize()
	get_cards()
	CardManager.connect("card_chosen", self, "add_new_card")
	
func add_new_card(card: PackedScene, permanent: bool):
	var new_card = card.instance()
	new_card.z_index = -all_cards.size()-5 #Not sure if this works properly
	add_child(new_card)
	if new_card is BasicCard:
		for card in get_children():
			if card is BasicCard:
				new_card.blueprint.visible = card.blueprint.visible
				new_card.blueprint.blueprint_toggled = card.blueprint.blueprint_toggled
	new_card.connect("card_executed", self, "_on_card_executed")
	if permanent:
		cards.append(new_card)
	all_cards.append(new_card)
	new_card.grid = get_child(0).grid

func get_cards():
	all_cards.clear()
	cards.clear()
	yield(get_tree(), "idle_frame")
	for card in get_children():
		cards.append(card)
		all_cards.append(card)
		card.additional_features.exhausted = false
		if !card.is_connected("card_executed", self, "_on_card_executed"):
			card.connect("card_executed", self, "_on_card_executed")
	shuffle_cards()
	get_no_queue_cards()

func encounter():
	get_cards()

func _on_card_executed(card: Card):
	if player.turns_remain < card.required_energy:
		return
		
#	yield(get_tree(), "idle_frame")
#	if !chance_to_execute:
#		card_execution_nofifier.call_func(card)
#		player.turns_remain -= card.required_energy
#		return
	card.execute(player, card_execution_nofifier)
	player.turns_remain -= card.required_energy

func get_no_queue_cards():
	for card in all_cards:
		if card.additional_features.features["no queue"]:
			all_cards.erase(card)
			all_cards.insert(0, card)
	for card in all_cards:
		card.z_index = -all_cards.find(card)

func shuffle_cards():
	all_cards.shuffle()
	for card in all_cards:
		card.z_index = -all_cards.find(card)
