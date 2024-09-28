extends EffectClass

func init(duration: int):
	.init(duration)
	if self.is_queued_for_deletion():
		return
	effect_owner.disconnect("new_health", effect_owner, "on_new_health")
	effect_owner.connect("new_health", self, "on_new_health")
#	if not check_same_effect():
#	.create_indicator(indicator_image)

#func set_debuff_count(value: int = 0):
#	effect_owner.invincible = false
#	.set_debuff_count(value)
#	if debuff_count > 0:
#		effect_owner.invincible = true

func debuff_run_out():
	effect_owner.disconnect("new_health", self, "on_new_health")
	effect_owner.connect("new_health", effect_owner, "on_new_health")
	.debuff_run_out()

func on_new_health(_value):
	return #Basically nothing happens, as health doesn't change
