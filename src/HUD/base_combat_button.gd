extends TextureButton

func toggle_button(value):
	disabled = value

func _on_BaseCombatButton_button_up():
	$ButtonClick.play()
