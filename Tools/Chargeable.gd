extends Node

var charge_feature
var my_owner: Card
export var charge_features: Dictionary

func define_feature(feature):
	print("WORKS?")
	#Crude Very Crude. Here we have only one feature whereas in CardToolManager
	#There's an assumption of multiple features
	charge_feature = get_child(0)
	charge_feature.script = load(charge_features[feature])
	charge_feature.change_params = funcref(self, "change_parameters") #Double line?

func init():
	if get_child_count() == 0:
		print("No feature found")
		breakpoint
	charge_feature = get_child(0)
	charge_feature.change_params = funcref(self, "change_parameters") #Double line?
	charge_feature.init(my_owner)
	create_button()
	pass

func describe(description: Dictionary): #Old feature, need to overhaul
	description["[chargeable]"] = "chargeable"

func create_button():
	var button = Button.new()
	button.connect("pressed", self, "charge_the_card")
	button.set_position(Vector2(42, 189))
	button.pause_mode = Node.PAUSE_MODE_PROCESS
	button.text = "charge"
	my_owner.add_child(button)

func change_parameters(value):
	charge_feature.change_parameters(my_owner, value)
#	my_owner.parameters.params["[required_energy]"] += 
	
func charge_the_card():
	charge_feature.feature(my_owner)
