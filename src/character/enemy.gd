extends Battler
class_name Enemy

func _ready():
	role = roles.ENEMY

func play_turn():
	yield(get_tree().create_timer(2), "timeout")
	Global.dialogue_box.show_comment(['Enemy tickles you!'], false)
	yield(Global.dialogue_box, "comment_done")
