extends Area2D

class_name Execution

var my_owner
var my_owner_identity

func _on_CardExecution_body_entered(body):
	if my_owner is Card:
		my_owner.executed(body)
	elif my_owner.is_in_group("Enemies"):
		if !body.is_in_group("Player"):
			return
		my_owner.executed(body)
#	my_owner_identity = my_owner.get_class()
#	print(my_owner_identity)
#	match my_owner_identity:
#		Card:
#			
#		SimpleEnemy:

func _on_Timer_timeout():
	queue_free()
