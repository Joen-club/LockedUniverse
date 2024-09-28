extends EnemyState

var attack_preview: PackedScene
export var preview_toggled: bool
var actual_scale: float

func _ready():
	attack_preview = preload("res://Tools/Preview.tscn")
	actual_scale = rand_range(1, 1.13)

func _input(event):
	if event.is_action_pressed("EnemyPreview"):
		toggle_preview()

func toggle_preview():
	if !preview_toggled:
		preview_toggled = true
		for position in attack_pattern:
			var actual_preview = attack_preview.instance()
			actual_preview.modulate = "8980e4e2"
			actual_preview.scale *= actual_scale
			var pos = my_owner.grid.world_to_map(my_owner.my_position) + position
			actual_preview.position = my_owner.grid.map_to_world(pos)
			actual_preview.add_to_group("EnemiesPreview")
			my_owner.add_child(actual_preview)
	elif preview_toggled:
		preview_toggled = false
		for preview in my_owner.get_children():
			if preview.is_in_group("EnemiesPreview"):
				preview.queue_free()


func Mouse_clicked(_viewport, event, _shape_idx):
	if event.is_action_pressed("Right_click"):
		toggle_preview()
