extends BasicCard


func _ready():
	pass

func executed(receiver: Entity):
	receiver.invincible = true
