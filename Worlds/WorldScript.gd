extends Node2D

onready var enemies = $Enemies
var player: Entity
export var player_position: Vector2
var grid: Pathfinding

signal scene_transit

func _ready():
	for enemy in enemies.get_children():
		enemy.connect("died", self, "_check_if_all_dead")
	grid = $Grid

func enemy_turn():
	
	pass

func _check_if_all_dead(enemy_dead: Entity):
	enemy_dead.queue_free()
	enemy_dead = null
	yield(get_tree().create_timer(.5), "timeout")
	if enemies.get_child_count() == 0:
		emit_signal("scene_transit")
		player.propagate_call("battle_end", [], true)

func start():
	player.global_position = grid.map_to_world(player_position)
