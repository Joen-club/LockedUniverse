extends EffectClass

#export var debuff_count: int = 2 #setget set_debuff_count
#
#func set_debuff_count(value):
#	debuff_count -= value
#	if debuff_count <= 0:
#		queue_free()
