extends BasicCard

var player: Entity
var timer = Timer.new()

func _ready():
	._ready()
	player = get_tree().get_nodes_in_group("Player").front()
#	timer.connect("timeout", self, )

func executed(receiver: Entity):
	.executed(receiver)
	tp_random(receiver)

func tp_random(receiver: Entity):
	var initial_pos  = grid.world_to_map(receiver.global_position)
	var new_pos = grid.used_cells[randi() % grid.used_cells.size()]
	while grid.excluded_cells.has(new_pos) or new_pos == initial_pos:
		new_pos = grid.used_cells[randi() % grid.used_cells.size()]
	
	
	if receiver.is_in_group("Enemies"):
		if receiver.health <= 0:
			return #Временно добавил эти строки, чтобы не было ошибок когда враг умирает
		receiver.enemy_state.moving_here([])
		receiver.enemies_cells_remove()
		receiver.global_position = grid.map_to_world(new_pos)
#		if receiver != null:
		receiver.enemies_cells_append()
		yield(get_tree(), "idle_frame")
		player.highlight.call_deferred("highlight")
	else: receiver.global_position = grid.map_to_world(new_pos)
