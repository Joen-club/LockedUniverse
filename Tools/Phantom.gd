extends Sprite

var player: Entity
export var duration: int = 2

func init():
# warning-ignore:return_value_discarded
	player.connect("debuff", self, "set_count")
	
func set_count(value: int = 0):
	duration -= value
	if duration <= 0:
		queue_free()
