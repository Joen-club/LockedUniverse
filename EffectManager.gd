extends Node2D

var my_owner: Entity #Assign player/enemy

export var entity_effects: Dictionary = {}

export var card_features: Dictionary = {} #In an inherited class

onready var entity_effects_node = $EntityEffects
onready var card_features_node = $CardFeatures

func check_feature(card: Card): #In an inherited class
	feature_area(card.additional_features.features) 

#func check_entity_effects():
#	feature_area(entity_effects)

func feature_area(card: Card): 
	var card_features = card.additional_features.features
	for k in card_features:
		if card_features[k]:
			if card_features_node.has_node(k):
				var new_action = card_features_node.get_node(k) #Slow...
				new_action.execution()

func entity_effects(card: Card, effect_group: String):
	var count_effects: int = 0
	for i in entity_effects_node.get_children():
		if i.is_in_group(effect_group):
			count_effects += 1
			i.execute_effect()
	
	
	
	if entity_effects_node.get_child_count() == 0:
		my_owner.set_health(card.actual_value)
		return
		if entity_effects_node.has_node("Invincible"):
			return
		elif entity_effects_node.has_node("Curse"):
			var effect = entity_effects_node.get_node("Curse")
			effect.apply_effect(my_owner) #The func doesn't exist yet

func health_effects():
	var count_health_effects: int = 0
	for i in entity_effects_node.get_children():
		if i.is_in_group("health"):
			i.execute_effect()

"""Короче, тут ноды фичи, соответствующие необходимым фичам/эффектам в картах/
игроке. У нод есть переменная bool которая возвращается ф-цией ноды, если True,
дека играет свою ф-цию, если false - нет. Пока что так попробуем"""
