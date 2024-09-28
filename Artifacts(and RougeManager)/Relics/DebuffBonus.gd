extends RelicClass

export var count_capacity: int

func _ready():
	pass

func execute(_caller):
	print("HELL")
	if my_owner.debuff_count >= count_capacity:
		yield(get_tree(), "idle_frame")
		my_owner.turns_remain += 1
