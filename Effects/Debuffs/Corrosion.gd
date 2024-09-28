extends EffectClass

var card_to_affect: Card
#export var indicator: PackedScene

#var call_indicator

func init(duration: int):
	.init(duration)
	var deck = effect_owner.find_node("Deck", true, true)
	if deck == null:
		breakpoint
	card_to_affect = deck.get_child(randi() % deck.get_child_count())
	while card_to_affect.parameters.default_params["[value]"] == 0: #Crude
		card_to_affect = deck.get_child(randi() % deck.get_child_count())
	print(card_to_affect)
	create_indicator(indicator_image)
	
func create_indicator(new_image: String):
	###Test
	var new_indicator = indicator.instance()
	new_indicator.image = new_image
	new_indicator.description = description
#	new_indicator.add_to_group("Corrosion")
	card_to_affect.container_debuff.add_child(new_indicator)
	card_to_affect.connect("card_executed", self, "corrosion")
	call_indicator = new_indicator

func set_debuff_count(value: int = 0):
	.set_debuff_count(value)
	call_indicator.counter.text = str(debuff_count)

func check_same_effect():
	if effect_owner.has_node(effect_name) and effect_owner.get_node(effect_name) != self:
		effect_owner.debuff_count += self.debuff_count
	
#func debuff_run_out():
##	for k in card_to_affect.get_children():
##		if k.is_in_group("Corrosion"):
##			k.queue_free()
##			break
#	queue_free()

func corrosion(card: Card, hovered: bool = false):
	yield(get_tree().create_timer(.2), "timeout") #Without this it will reduce damage before hit
	if !hovered:
		card.parameters.params["[value]"] += 2
#		.set_debuff_count(1)
	
