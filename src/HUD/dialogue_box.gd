extends Control
onready var text_label = $Background/VBoxContainer/MarginContainer/RichTextLabel

signal comment_done
signal next_pressed
		
func _process(_delta):
	if Input.is_action_just_pressed("left_click"):
		emit_signal("next_pressed")
		
func show_comment(comments, break_at_end):
	var count = 0
	for value in comments:
		text_label.percent_visible = 0
		text_label.text = value
		$AnimationPlayer.play("start")
		yield($AnimationPlayer, "animation_finished")
		count += 1
		if count == comments.size() and break_at_end:
			break
		yield(self, "next_pressed")
		
	emit_signal("comment_done")
