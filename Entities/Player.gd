extends Entity

export var this_state_machine_path: NodePath
export var highlight_path: NodePath
export var HUD_path: NodePath
export var deck_manager_path: NodePath
export var rouge_manager_path: NodePath

onready var highlight: Node = get_node(highlight_path)
onready var this_state_machine: Node = get_node(this_state_machine_path)
onready var HUD: CanvasLayer = get_node(HUD_path)
#onready var debuff_container = $DebuffContainer

#Messy
onready var deck_manager = get_node(deck_manager_path)
onready var rouge_manager = get_node(rouge_manager_path)

var player_end_turn: FuncRef


signal test

func _ready():
	this_state_machine.HUD_notification = funcref(self, "update_HUD")
	this_state_machine.init(self)
	highlight.player = self
	deck_manager.define_player(self)

func start_turn():
	deck_manager.put_cards_in_hand()
	.start_turn()
	emit_signal("relic_effect", self)
	highlight.call_deferred("highlight")

func battle_end():
	debuff_count = 0

func set_turns(value):
	turns_remain = value
	if highlight != null:
		highlight.call_deferred("highlight")
	if turns_remain <= 0:
		player_end_turn.call_deferred("call_func")

#func set_health(value):
#	.set_health(value)
#	if not invincible and not cursed:
#		print(health, value)
#		health = value
#		print(health)
#		if health <= 0:
#			print("LOX")

func on_new_health(value):
	.on_new_health(value)
	if health <= 0:
		print("LOX")

#func set_debuff_count(value): #Рудиментарная ф-ция пока что. Можно что-то получше придумать
#	debuff_count = value
#	print(debuff_count)
##	emit_signal("relic_effect", self)

func update_HUD(new_state_name: String):
	HUD.show_new_state(new_state_name)

"""set weight for the player's end turn"""
