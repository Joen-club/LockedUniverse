extends Panel

class_name CardsGrid

var my_count: int = 0 #Variable is used for getting cards by their ID in an array
var shown_cards: Array #The array is used to not repeat the same cards in a deck
var deck: Node2D #Deck is assinged by the "CanvasLayer" Node (Gotta rename it soon)
var columns: int = 5 #The number of columns on the screen
var rows: int = 3 #The number of rows

##Initially this func gets rid of all the previous data and card grids prior to
##Creating the new one. Check this function in the class inhabitants to see more
func create_grid(count: int = 0):
	for button in self.get_children():
		if button is Button:
			button.queue_free()
	for card in shown_cards:
		card.global_position = deck.global_position
	shown_cards.clear()
	my_count = count

## As all cards can't be placed on one screen, after 15th card there creates a 
## button to the next and previous page.
func check_grid_size():
	if deck.cards.size() > my_count:
		create_button("next")
	if my_count > 15:
		create_button("prev")

## This func creates a button and assignes a certain signal with the variable
## "This count" to the button. Keep in mind that func "check_grid_size()" call
## this one twice, for the "next" and "prev" buttons, meaning that they will have
## different values of the variable "this_count"

## For example, in the second page of cards, the "next" button with the var "this
## count" has a value of 30, and that's the value it calls the func "create_grid()" with
## Whereas the "prev" value has a value of 0, because 30-30 = 0. So pressing this
## button calls "create_grid()" with the value of 0. 
func create_button(what_button: String):
	var button = Button.new()
	var this_count = my_count
	match what_button:
		"next":
			button.set_position(Vector2(1200, 600))
		"prev":
			button.set_position(Vector2(1150, 600))
			this_count -= 30
	button.pause_mode = Node.PAUSE_MODE_PROCESS
	button.text = what_button
	button.connect("pressed", self, "create_grid", [this_count])
	add_child(button)
