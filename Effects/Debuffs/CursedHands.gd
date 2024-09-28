extends EffectClass
"""Need to clean allllllll the mess I've done yesterday"""
var deck: Node2D

func init(duration: int):
	print("ALLALAL")
	.init(duration)
	if self.is_queued_for_deletion(): 
		return
	deck = effect_owner.find_node("Deck", true, true)
	if deck == null:
		breakpoint
	for i in deck.get_children():
		i.disconnect("card_executed", deck, "_on_card_executed")
		print(i.is_connected("card_executed", deck, "_on_card_executed"))
		i.connect("card_executed", self, "chance_to_execute")

func set_debuff_count(value: int = 0):
	.set_debuff_count(value)
#	yield(get_tree().create_timer(1), "timeout")
#	call_deferred("debuff_run_out")

func debuff_run_out():
	for i in deck.get_children():
		
		i.connect("card_executed", deck, "_on_card_executed", [i])
		print(i.is_connected("card_executed", deck, "_on_card_executed"))
	.debuff_run_out()

func chance_to_execute(card: Card):# hovered: bool):
#	if !hovered:
	var k = randi() % 3+1
	print(k)
	if k > 2:
		print("works")
		deck.card_execution_nofifier.call_func(card)
		effect_owner.turns_remain -= card.required_energy
	else: deck._on_card_executed(card)
