extends EffectClass

func init(duration: int):
	.init(duration)
	if self.is_queued_for_deletion():
		return
	effect_owner.disconnect("new_health", effect_owner, "on_new_health")
	effect_owner.connect("new_health", self, "on_new_health")
#	effect_owner.cursed = true

#func set_debuff_count(value: int = 0):
##	effect_owner.cursed = false
#	.set_debuff_count(value)
#	if debuff_count > 0:
#		effect_owner.cursed = true

func debuff_run_out():
	effect_owner.disconnect("new_health", self, "on_new_health")
	effect_owner.connect("new_health", effect_owner, "on_new_health")
	.debuff_run_out()
	
func on_new_health(value):
	effect_owner.on_new_health(0)
#	effect_owner.emit_signal("died") #Pseudo
