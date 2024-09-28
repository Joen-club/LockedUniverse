extends Node

var new_grid: Pathfinding
var player: Entity
var new_world

onready var map = $RougeManager/Global_HUD/Map
onready var rouge_manager = $RougeManager

func _ready():
	map.connect("scene_transit", self, "_on_scene_transit")
	get_player()
	get_new_world_props()
	player.connect("died", rouge_manager, "on_player_died")

func level_transition():
	player.visible = false
	map.my_visible = true
	map.scene_transition = true
	new_world.queue_free()
	propagate_call("scene_transition")

func its_enemy_turn():
	$Timer.start(.2)
	yield(get_tree().create_timer(.15), "timeout")
	new_grid.spawn_cell(2)
	var enemies = get_tree().get_nodes_in_group("Enemies")
	if enemies.empty():
		return
	for enemy in enemies:
#		yield(get_tree(), "idle_frame")
		if !enemy.has_method("start_turn") and enemy != null:
			print_debug(enemy, " doesn't have a method 'start_turn'")
			breakpoint
		yield(enemy.start_turn(), "completed")
	yield(get_tree().create_timer(.4), "timeout")
	player.start_turn()

func get_new_world_props():
	new_world = get_tree().get_nodes_in_group("Worlds").front()
	new_grid = new_world.grid
#	new_grid = get_tree().get_nodes_in_group("Grid").front()
	new_world.connect("scene_transit", self, "level_transition")
	rouge_manager.move_child(new_world, 0)
	new_world.player = player
	new_world.start()
	propagate_call("define_grid", [new_grid])
	player.visible = true
	player.start_turn()

func get_player():
	player = get_tree().get_nodes_in_group("Player").front()
	player.player_end_turn = funcref(self, "its_enemy_turn")

func _on_scene_transit(my_new_world: String, encounter: bool):
	var load_world = load(my_new_world)
	var actual_world = load_world.instance()
	rouge_manager.add_child(actual_world)
	if encounter:
		propagate_call("encounter")
		get_new_world_props()
	else: 
		new_world = actual_world
		actual_world.connect("scene_transit", self, "level_transition")


func _on_Timer_timeout():
	pass # Replace with function body.
