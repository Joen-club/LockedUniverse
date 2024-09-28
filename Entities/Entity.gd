extends KinematicBody2D

class_name Entity

export var health: float  setget set_health
export var max_health: float
export var turns_remain: int setget set_turns
export var turns_capacity: int
export var invincible: bool #Health can't be changed
export var cursed: bool #Dies in one hit
var debuff_count: int setget set_debuff_count

onready var sprite = $Sprite
onready var debuff_container = $DebuffContainer
var health_bar

signal relic_effect
signal debuff(count)
signal died
signal new_health

func _ready():
	connect("new_health", self, "on_new_health")
	health = max_health
	print(health, " health")

func set_turns(value: int):
	turns_remain = value

func set_health(value):
	printt(health, value)
	#New: effect_manager.check_entity_feature ##03.06.24: Возможно, эта система слишком громоздкая
	
	#Можно сделать через чеки детей в ноде... Тоже самое фактически
	
	#Можно сделать отдельную сцену healthManager для entity, 
	#к которому подаётся сигнал; эффекты перехватывают этот сигнал
	emit_signal("new_health", value)
	
#	if invincible: 
#		return
#	if cursed:
#		health = 0
#		emit_signal("died", self)
#		return

func set_debuff_count(value): #Рудиментарная ф-ция пока что. Можно что-то получше придумать
	debuff_count = value
	print(debuff_count)
#	emit_signal("relic_effect", self)

func on_new_health(value):
	health = value

func start_turn():
	if turns_remain < turns_capacity:
		set_deferred("turns_remain", turns_capacity)
	yield(get_tree(), "idle_frame")
	emit_signal("debuff", 1)
