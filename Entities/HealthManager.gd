extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_health(my_owner: Entity, value):
	my_owner.health = value

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
