extends EffectClass

export var trash_card: PackedScene

func init(duration: int):
	.init(duration)
	CardManager.emit_signal("card_chosen", trash_card, false)
	queue_free()
