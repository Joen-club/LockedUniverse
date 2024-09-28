extends CanvasLayer

onready var deck: Node2D = $Deck
onready var perma_panel: Panel = $PermaCards
onready var all_panel: Panel = $AllCards
onready var discarded_panel: Panel = $DiscardedCards

var is_paused: bool = false

signal return_hand_cards

func _ready():
	perma_panel.visible = false
	all_panel.visible = false
	discarded_panel.visible = false
	perma_panel.deck = deck
	all_panel.deck = deck

func scene_transition():
	$All_cards.visible = false
func encounter():
	$All_cards.visible = true

func choose_panel(what_button: String):
	var what_panel: Panel
	match what_button:
		"All_panel":
			what_panel = all_panel
		"perma_panel":
			what_panel = perma_panel
		"discarded_panel":
			what_panel = discarded_panel
	if what_panel.visible:
		if not is_paused:
			get_tree().paused = false
			
		for card in what_panel.shown_cards:
			if card.additional_features.exhausted:
				card.global_position = Vector2(10000, 10000)
			else:
				card.global_position = deck.global_position
				
		what_panel.shown_cards.clear()
		what_panel.my_count = 0
		what_panel.visible = false
		emit_signal("return_hand_cards")
	else: 
		
		if get_tree().paused:
			is_paused = true
		else:
			is_paused = false
			
		for card in deck.get_children():
			if card.in_hand:
				card.global_position = deck.global_position
		get_tree().paused = true
		what_panel.visible = true
		what_panel.create_grid()

func _on_Map_pressed():
	GameManager.emit_signal("map_toggled")
	pass # Replace with function body.
