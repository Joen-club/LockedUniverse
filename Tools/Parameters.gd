extends Node

export var default_params: Dictionary  = {
	"[required_energy]": 1,
	"[value]": 0,
}
export var params: Dictionary setget set_new_param
export var effects_params: Dictionary setget set_new_effect
export var feature_params: Dictionary setget set_new_feature
## This is something I hate
var card_description: Control
var my_owner: Card

func _ready():
	params.merge(default_params)

func init(new_owner: Card, my_description: Control):
	my_owner = new_owner
	card_description = my_description
	describe()

func scene_transition():
	params.merge(default_params, true)
	describe()

func describe():
	card_description.set_words(params, "key")
	card_description.set_words(effects_params, "effect")
	card_description.set_words(feature_params, "feature")

func set_new_effect(value):
	effects_params = value
	if my_owner == null: return
#	my_owner.update_params() #?
	card_description.set_words(effects_params, "effect")

func set_new_feature(value):
	feature_params = value
	if my_owner == null: return
#	my_owner.update_params() #?
	card_description.set_words(feature_params, "feature")

## This is the something weird motherfu
func set_new_param(value):
	params = value
	if my_owner == null: return
	my_owner.update_params() #?
	card_description.set_words(params, "key")
