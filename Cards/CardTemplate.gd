extends Card

class_name BasicCard

export var blueprint_path: NodePath

onready var blueprint = get_node(blueprint_path)

"""
#For extended_area:
#Up: 9, Down: 4, Left:2, Right:5, D_Right_Up: 8, D_Left_Down: 3,
#D_Left_Up: 7, D_Right_Down:: 6. D stands for "Diagonal"
"""

"""Возможно ф-цию execute в том виде в котором она сейчас в Card, стоило бы
переместить в BasicCard класс, ибо все карты этого типа используют её в то
время как карты в areas - практически нет. 19.05.24: Done; testing """

func _ready():
	blueprint.description = card_description
	blueprint.draft_the_sketch(activate_cells, additional_features.extended_area)

func _on_Area2D_mouse_entered(): 
	yield(get_tree(), "idle_frame") # *** Without it the description panel blocks preview
	blueprint.preview(activate_cells, grid)

func execute(player: Entity, managing_card: FuncRef):
	for n in activate_cells:
		var cell = grid.world_to_map(player.global_position) + n
		if !grid.used_cells.has(cell):
			continue
		var area = card_execution.instance()
		area.global_position = grid.map_to_world(cell)
		area.my_owner = self
		get_tree().root.add_child(area)
	.execute(player, managing_card)

func executed(receiver: Entity):
	#For buffs and debuffs overwrite this function
	receiver.health += actual_value #Value is negative for attacks and positive for buffs

func _on_Area2D_mouse_exited():
	for sprite in get_tree().get_nodes_in_group("CardPreview"):
		sprite.queue_free()
