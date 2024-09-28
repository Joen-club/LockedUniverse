extends RichTextLabel

var my_owner: Card

func _gui_input(event):
	if event.is_action_pressed("Left_click"):
		my_owner._on_Area2D_input_event(null, event, null)

func _on_RichTextLabel_mouse_entered():
	if !my_owner.has_method("_on_Area2D_mouse_entered") or get_tree().paused:
		return
	my_owner._on_Area2D_mouse_entered()

func _on_RichTextLabel_mouse_exited():
	if !my_owner.has_method("_on_Area2D_mouse_exited"):
		return
	my_owner._on_Area2D_mouse_exited()

"""СУПЕР КОСТЫЛЬ Я Ипал"""
