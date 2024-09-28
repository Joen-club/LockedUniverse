extends RelicClass


func _ready():
	call_deferred("execute")
	pass

func execute(_caller):
	print(my_owner.value)
	my_owner.value *= 1.5
	print(my_owner.value)
