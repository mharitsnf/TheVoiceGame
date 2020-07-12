extends Control

func receive_damage():
	$Tween.interpolate_property(self, 'rect_position', rect_position, rect_position + Vector2(10, 0), 0.05, Tween.TRANS_QUAD, Tween.EASE_OUT)
	$Tween.start()
	yield($Tween, "tween_all_completed")
	$Tween.interpolate_property(self, 'rect_position', rect_position, rect_position - Vector2(10, 0), 0.05, Tween.TRANS_QUAD, Tween.EASE_OUT)
	$Tween.start()
	yield($Tween, "tween_all_completed")
	$Tween.interpolate_property(self, 'rect_position', rect_position, rect_position + Vector2(10, 0), 0.05, Tween.TRANS_QUAD, Tween.EASE_OUT)
	$Tween.start()
	yield($Tween, "tween_all_completed")
	$Tween.interpolate_property(self, 'rect_position', rect_position, rect_position - Vector2(10, 0), 0.05, Tween.TRANS_QUAD, Tween.EASE_OUT)
	$Tween.start()
	yield($Tween, "tween_all_completed")

func activate_def_sign():
	$HBoxContainer/VBoxContainer/DefSign.show()
	
func deactivate_def_sign():
	$HBoxContainer/VBoxContainer/DefSign.hide()
	
