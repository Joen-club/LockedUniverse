extends Control

var image: String
var description: String
export var description_panel: PackedScene

onready var my_image = $TextureRect
onready var counter = $Label
var description_node: CanvasLayer

func _ready():
	my_image.texture = load(image)

func battle_end():
	queue_free()

func _on_TextureRect_mouse_entered():
	var shown_description: = description_panel.instance()
	shown_description.new_text = description
	shown_description.name = "description"
	description_node = shown_description
	get_tree().root.add_child(shown_description)

func _on_TextureRect_mouse_exited():
	description_node.queue_free()
#	get_node("description").queue_free()
