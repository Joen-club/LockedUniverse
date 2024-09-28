extends Node2D
class_name Card

export var card_execution: PackedScene #*Do I need this here?

var grid: Pathfinding 
export var card_type: PoolStringArray #Damage, Buff, Debuff *Do I even need this?
#export var indicators: PoolStringArray #Melee, Range Isn't being used for now
export var extended_area: Array #Up: 9, Down: 4, Left:2, Right:5, D_Right_Up: 8, D_Left_Down: 3,
									#D_Left_Up: 7, D_Right_Down:: 6. D stands for "Diagonal"
export var activate_cells: PoolVector2Array #Areas of affecting entities
onready var required_energy: int
onready var actual_value: int #used in battles
export var in_hand: bool = false #'export' For testing and debug. Don't touch otherwise
export var cost: int #*For shop. Didn't do much about that for now

onready var parameters: Node = $Parameters #Default_parameters and effect
onready var card_description: Control = $CardDescription 
onready var additional_features: Node = $AditionalFeatures #Things like exhaust etc.
onready var card_tool_manager: Node = $CardToolManager #Buttons like inverse, charge etc.
onready var container_debuff: GridContainer = $GridContainer #For debuff indicators
onready var effect_manager: Node2D = $NewEffectManager

# warning-ignore:unused_signal
signal card_executed(card_identifier)
signal relic_effect

func _ready():
	update_params()
	propagate_call("describe_new", [parameters])
	parameters.init(self, card_description)
	card_tool_manager.define_owner(self)
#	parameters.describe()
	card_description.define_owner(self)

func update_params():
	actual_value = parameters.params["[value]"]
	required_energy = parameters.params["[required_energy]"]

func define_grid(new_grid: Pathfinding):
	self.grid = new_grid

func execute(_player: Entity, managing_card: FuncRef):
	#Unique cards would need to overwrite this fuction
#	if card_type.empty():
#		print_debug("There's no card_type in ", self.name)
#		breakpoint
	managing_card.call_func(self)

func apply_effect():
	pass

func executed(_receiver: Entity):
	pass

func _on_Area2D_input_event(_viewport, event, _shape_idx):
	if event.is_action_pressed("Left_click"):
		if !in_hand:
			return
		emit_signal("card_executed", self)
		emit_signal("relic_effect") #Pseudocode
