extends ViewportContainer

export var blueprint_path: NodePath
onready var blueprint = get_node(blueprint_path)
var player: Entity
var blueprint_toggled: bool
var description: Control

export var card_preview: PackedScene

func _ready():
	visible = false
	player = get_tree().get_nodes_in_group("Player").front()

func draft_the_sketch(activate_cells: PoolVector2Array, extended_area: Array):
	blueprint.draft_the_sketch(activate_cells, extended_area)

func clean():
	blueprint.clean()

func _input(event):
	if event.is_action_pressed("CardsBlueprients"):
		if blueprint_toggled:
			visible = false
			description.my_description.visible = true
		else:
			visible = true
			description.my_description.visible = false
			description._on_RichTextLabel_meta_hover_ended(null)
		blueprint_toggled = !blueprint_toggled

func preview(activate_cells, grid: Pathfinding):
	if !get_tree().get_nodes_in_group("CardPreview").empty():
		return
	for n in activate_cells:
		var cell = grid.world_to_map(player.global_position) + n
#		if !grid.used_cells.has(cell):
#			continue
		var new_preview = card_preview.instance()
		new_preview.global_position = grid.map_to_world(cell)
		new_preview.add_to_group("CardPreview")
		get_tree().root.add_child(new_preview)
