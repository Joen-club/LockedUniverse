extends StateMachine

var HUD_notification: FuncRef
var grid: Pathfinding

func define_grid(set_grid: Pathfinding):
	grid = set_grid
	for my_state in get_children():
		if my_state is State:
			states[my_state.name] = my_state
			my_state.grid = grid
			

func init(ownership: Entity):
	if !ownership.is_in_group("Player"):
		print(ownership)
		breakpoint
	for my_state in get_children():
		if my_state is State:
			my_state.my_owner = ownership
			my_state.connect("state_transition", self, "on_state_transition")
	HUD_notification.call_func(current_state.name)

func _ready():
	GameManager.connect("change_state", self, "on_state_transition")
	if initial_state_path: 
		current_state = get_node(initial_state_path)

func scene_transition():
	set_process_input(false)

func encounter():
	set_process_input(true)

func _input(event):
	var cell = grid.world_to_map(grid.get_global_mouse_position())
	if not current_state.name == "Choosing":
		if event.is_action_pressed("Right_click"):
			on_state_transition("Build")
		if event.is_action_pressed("Left_click"):
			on_state_transition("Move")
	if current_state:
		if current_state.grid == null: #Debug. So I could use this scene separately from
			#the grid.
			return
		current_state.input(event, cell)

func on_state_transition(new_state: String, opt_card = null):
	if current_state.name == new_state: 
		return
	var now_state = states.get(new_state)
	if !now_state: 
		print(now_state)
		breakpoint

	current_state = now_state
	current_state.enter_state(opt_card)
	HUD_notification.call_func(current_state.name)
