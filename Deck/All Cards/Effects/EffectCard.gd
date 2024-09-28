extends BasicCard

class_name EffectCard

export var value_and_effect: bool 
export var effect_type_path: Array #There can be multiple effects with one card
#Need to test though

func executed(receiver: Entity):
	if value_and_effect:
		.card_executed(receiver)
	for i in effect_type_path:
		var new_effect = get_node(i)
		new_effect.effect(receiver)
#	effect_type.effect(receiver)
