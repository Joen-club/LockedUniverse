extends Node

class_name EffectClass

var debuff_count: int
var grid: Pathfinding
var effect_owner: Entity
export var effect_name: String
export var description: String

export var indicator: PackedScene
export var indicator_image: String = "res://icon.png"
var call_indicator = null

func init(duration: int):
	effect_owner = get_parent() #Either player or enemy
	grid = get_tree().get_nodes_in_group("Grid").front() #Temporary 09.06.24: seems like only Confusion uses it
	debuff_count = duration
	effect_owner.debuff_count += duration
	check_same_effect()
	if self.is_queued_for_deletion():
		return

func battle_end():
	queue_free()

func set_debuff_count(value: int = 0): #Emits every time the signal "debuff" is being called
	if effect_owner == null or grid == null:
		init(value)
		print_debug("init function hasn't been called or there's an error")
		print_debug("Grid - ", grid, "Owner - ", effect_owner)
		breakpoint
	debuff_count -= value
	if call_indicator != null:
		call_indicator.counter.text = str(debuff_count)
#	if effect_owner.is_in_group("Player"):
	effect_owner.debuff_count -= value
	if debuff_count <= 0: 
		debuff_run_out()

func debuff_run_out():
	if call_indicator != null:
		call_indicator.queue_free()
	queue_free()

func check_same_effect():
	if effect_owner.has_node(effect_name) and effect_owner.get_node(effect_name) != self:
		var same_effect = effect_owner.get_node(effect_name)
		same_effect.debuff_count += self.debuff_count
#		same_effect.call_indicator.counter.text = str(same_effect.debuff_count) #get rid of comment
		call_indicator = same_effect.call_indicator
		queue_free()
	else: 
		create_indicator(indicator_image)

func create_indicator(image: String): 
	return #Temp
	"""Got to work on the function for the entities"""
	var new_indicator = indicator.instance()
	new_indicator.image = image
	new_indicator.description = description
#	new_indicator.rect_scale = Vector2(2,2)
	effect_owner.debuff_container.add_child(new_indicator)
#	if effect_owner.scale.x < 1:
	
	call_indicator = new_indicator
