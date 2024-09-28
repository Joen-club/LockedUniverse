extends Entity

class_name SimpleEnemy

var player: Entity

var my_position: Vector2
var player_position: Vector2
var grid: Pathfinding

export var enemy_state_path: NodePath
onready var enemy_state = get_node(enemy_state_path)

func _ready():
	connect("died", self, "I_died")
	player = get_tree().get_nodes_in_group("Player").front()
	call_deferred("enemies_cells_append")
	health_bar = $HealthManager/HealthBar
	health_bar.max_value = health
	health_bar.value = health_bar.max_value
	enemy_state.init(self)

func define_grid(new_grid: Pathfinding):
	grid = new_grid

func start_turn():
	.start_turn()
	enemies_cells_remove()
	player_position = grid.world_to_map(player.global_position)
#	emit_signal("relic_effect")
	if !grid.used_cells.has(my_position):
		print_debug(grid, " doesn't have this position")
		breakpoint
#	grid.enable_points(my_position)
	grid.set_weight_for_cells(my_position, 1.0)
	yield(enemy_state.activate_state(), "completed")
	enemies_cells_append()

func enemies_cells_remove():
	my_position = grid.world_to_map(self.global_position)
	var k = grid.enemies_cells.find(my_position)
	if k != -1:
		grid.enemies_cells.remove(k)

func enemies_cells_append():
	my_position = grid.world_to_map(self.global_position)
	grid.enemies_cells.append(my_position)

func executed(this_player: Entity):
	enemy_state.executed(this_player)

#func set_health(value: int):
#	.set_health(value)
#	if not invincible and not cursed:
#		health = value
#		if health_bar != null:
#			health_bar.value = value
#		if health <= 0.0:
#			emit_signal("died", self)

func on_new_health(value):
	.on_new_health(value)
	if health_bar != null:
			health_bar.value = value
	if health <= 0.0:
		emit_signal("died", self)

func I_died(_me: Entity):
	grid.set_weight_for_cells(my_position, 1.0)
	player.highlight.highlight()
	enemies_cells_remove()
