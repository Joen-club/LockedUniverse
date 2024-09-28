extends CanvasLayer

onready var text = $Panel/RichTextLabel
onready var panel = $Panel
var new_text: String

func _ready():
	panel.set_global_position(panel.get_global_mouse_position() + Vector2(10, 10))
	print_text()

func _input(_event):
	panel.set_global_position(panel.get_global_mouse_position() + Vector2(10, 10))

func print_text():
	text.bbcode_text = "[center]%s[/center]" % new_text
