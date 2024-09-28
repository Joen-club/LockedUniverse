extends Node

class_name AdditionalState

var count: int #The point enemy gets after doing nothing within the turn
export var count_capacity: int #The amount of points enemy needs to get to get a buff

##At the beginning, each enemy gets their different effects that are triggered
##When the count equals to the count capacity.
func _ready():
	init()

func init():
	if count_capacity == count: #Debug
		print("Set 'count_capacity'")
		breakpoint

##If enemy does nothing, this func activates, increasing the count and then,
##If it's equal or more than capacity, the effect casts on a player
func compare_count(my_owner: Entity, value:int = 0):
	count += value
	if count >= count_capacity:
		count = 0
		new_action(my_owner)

func new_action(my_owner: Entity): #Use this func to make different actions
	my_owner.turns_remain += 1 #The default action is to get +1 energy.
	print_debug("RAGE_INCREASED")
