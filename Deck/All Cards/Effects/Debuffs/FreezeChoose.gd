extends ChooseCellCard

var enemy_poses: Dictionary
onready var effect = $Effect
var chosen_cell: Vector2

func _ready():
	pass

func execute(_none: Entity, _managing_card: FuncRef):
	.execute(_none, _managing_card)
	for i in enemy_poses:
		if enemy_poses[i] == chosen_cell:
			effect.effect(i)

func choosing_execute(new_chosen_cell: Vector2):
	for i in get_tree().get_nodes_in_group("Enemies"):
		enemy_poses[i] = grid.world_to_map(i.global_position)
		chosen_cell = new_chosen_cell
	if enemy_poses.values().has(chosen_cell):
		.choosing_execute(chosen_cell)
