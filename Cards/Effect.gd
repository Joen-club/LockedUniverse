extends Node

export var current_effect: PackedScene #There are effects in Buffs and debuffs folders
#(i.e blindness.tscn; confusion.tscn). Load them here
export var effect_duration: int #measured in turns 
#var player: Entity #By default the receiver of effect is player *Temporary*
export var effect_description: Dictionary 
var effect_name: String 

func _ready():
	var gay = current_effect.instance()
	effect_name = gay.effect_name
	effect_description["["+str(effect_name)+"]"] = gay.description
	gay.queue_free()

func effect(receiver: Entity):
	var new_effect = current_effect.instance()
	receiver.connect("debuff", new_effect, "set_debuff_count") #Debuff connects
	#To the receiver e.g. player of an enemy
	receiver.add_child(new_effect)
	new_effect.init(effect_duration)
	new_effect.set_debuff_count()
#	new_effect.check_same_effect()

func describe_new(parameters: Node):
	parameters.effects_params.merge(effect_description)
	parameters.params["["+str(effect_name)+"]"] = effect_name
	parameters.params["[duration]"] = effect_duration #If you have more than a one
	#effect, than duration will be the same for both. Do I need to change that?
