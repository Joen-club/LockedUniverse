extends Node

class_name EnemyState

export var attack_pattern: Array
export var value: int #Should be set to negative for damage
var my_owner: Entity
var execution: PackedScene
onready var additional_state = $AdditionalState

class MyCustomSorter:
	static func sort_ascending(a, b):
		if a.empty():
			return false
		elif b.empty():
			return true
		if a.size() < b.size():
			return true
		else:
			return false

func init(new_owner: Entity):
	my_owner = new_owner

func _ready():
	execution = preload("res://Tools/Execution.tscn")

func activate_state():
	var shortest_way: Array = []
	var players_positions: Array = get_tree().get_nodes_in_group("Player")
	yield(get_tree(), "idle_frame")
	if my_owner.turns_remain <= 0:
		return
	for players in players_positions:
		var player_position = my_owner.grid.world_to_map(players.global_position)
		for k in attack_pattern:
			var new_destination = player_position - k
			if new_destination == my_owner.my_position:
				yield(attacking(), "completed")
				return
			shortest_way.append(my_owner.grid.astar_get_path(my_owner.my_position, new_destination))
	shortest_way.sort_custom(MyCustomSorter, "sort_ascending")
	moving_here(shortest_way[0])
#	yield(moving_here(shortest_way[0]), "completed") #I realize the there are many yields
	#right here. But at the moment it's the only way to make enemies not move simultaneously

func moving_here(destination):
#	yield(get_tree(),"idle_frame") ###10.06.2024 ???
#	print(destination[-1])
	if destination.size() == 0:
		additional_state.compare_count(my_owner, 1)
	for k in my_owner.turns_remain:
		if my_owner.turns_remain <= 0:
			break
		for i in destination:
			if my_owner.turns_remain <= 0:
				my_owner.my_position = my_owner.grid.world_to_map(my_owner.global_position)
				my_owner.grid.set_weight_for_cells(my_owner.my_position, 70.0)
				break
			yield(get_tree().create_timer(0.2), "timeout")
			if my_owner.grid.world_to_map(my_owner.global_position) == destination[-1]:
				attack()
			else: 
				my_owner.global_position = my_owner.grid.map_to_world(i)
			my_owner.turns_remain -= 1

func attacking():
	for k in my_owner.turns_remain:
		yield(get_tree().create_timer(0.2), "timeout")
		attack()
		my_owner.turns_remain -= 1

func attack():
	for attack_area in attack_pattern:
		var execution_area = execution.instance()
		execution_area.position = my_owner.my_position + my_owner.grid.map_to_world(attack_area)
		execution_area.my_owner = my_owner
		my_owner.add_child(execution_area)

func Mouse_clicked(_viewport, _event, _shape_idx):
	pass

func executed(player: Entity):
	player.health += value #Set negative value to the export var in order to deal damage

"""make a function in case enemy can't come to a player"""
