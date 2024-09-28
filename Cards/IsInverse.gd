extends Node

#export var is_inverse: bool
#var inversed: bool = false #*This one can be used to return card to its default state
#var inversed_cells: PoolVector2Array

var my_owner: Card

func init():
#	for cell in my_owner.activate_cells:
#		cell = -cell
##		cell.x = -cell.x
##		cell.y = -cell.y
#		inversed_cells.append(Vector2(cell.x, cell.y))
	create_inversed_button()

func create_inversed_button():
	var inverse_button = Button.new()
	inverse_button.connect("pressed", self, "inverse_the_card")
	inverse_button.set_position(Vector2(42, 189))
	inverse_button.pause_mode = Node.PAUSE_MODE_PROCESS
	inverse_button.text = "inverse"
	my_owner.add_child(inverse_button)
	
func inverse_the_card():
	var temp: Array = []
#	for i in my_owner.activate_cells:
#		temp.append(i)
	temp.append_array(my_owner.activate_cells)
#	my_owner.index.clear()
#	print_debug(my_owner.index[1])
	for i in temp:# my_owner.activate_cells:
		var tempo = temp.pop_front()
		tempo = -tempo
		temp.push_back(tempo)
#		my_owner.activate_cells.push_back(tempo)
	my_owner.activate_cells = temp
	
#	print(my_owner.index[1])
#	match inversed:
#		true: my_owner.index.append_array(my_owner.activate_cells)
#		false: my_owner.index.append_array(inversed_cells)
		#No clue whether match is better than if/elif
#	if inversed:
#
#	elif !inversed:

	my_owner.blueprint.clean()
	my_owner.blueprint.draft_the_sketch(my_owner.activate_cells, my_owner.extended_area)
#	inversed = !inversed
