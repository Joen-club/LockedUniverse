extends Node

class_name RelicClass

onready var my_owner
var my_name: String = name
var owner_to_influence #It can basically be either an Array or a variable, so no hints

func _ready():
	init()
	my_owner.connect("relic_effect", self, "execute")

func init():
	pass

func execute(caller):
	if caller != my_owner:
		return
