extends EffectClass


func set_debuff_count(value: int = 0):
	effect_owner.invincible = false
	.set_debuff_count(value)
	if debuff_count > 0:
		effect_owner.turns_remain = 0
		effect_owner.invincible = true
