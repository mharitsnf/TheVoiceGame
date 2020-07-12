extends Control
onready var dialogue = $Background/VBoxContainer/MarginContainer/RichTextLabel
onready var name_bar = $SmallDialogueBox/VBoxContainer/MarginContainer/RichTextLabel

signal comment_done
signal next_pressed

		
func _process(_delta):
	if Input.is_action_just_pressed("left_click"):
		emit_signal("next_pressed")
		
func show_comment(comments : Array, break_at_end):
	var count = 0
	for value in comments:
		dialogue.percent_visible = 0
		dialogue.text = value.text
		name_bar.text = value.name
		$AnimationPlayer.play("start")
		yield($AnimationPlayer, "animation_finished")
		count += 1
		if count == comments.size() and break_at_end:
			break
		$MarginContainer/TextureRect.show()
		yield(self, "next_pressed")
		$MarginContainer/TextureRect.hide()
		
	emit_signal("comment_done")
