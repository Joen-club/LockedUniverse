extends RelicClass

var relic_count: int
export var relic_capacity: int

func init():
	owner_to_influence = get_tree().get_nodes_in_group("Player").front()

func execute(_caller):
	relic_count += 1
	if relic_count >= relic_capacity:
		relic_count = 0
		owner_to_influence.turns_remain += 1
