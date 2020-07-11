extends Battler
class_name MainCharacter

signal button_selected

func _ready():
	role = roles.PLAYER

func _attack_button_up():
	emit_signal("button_selected")

func _defend_button_up():
	emit_signal("button_selected")
	
func _items_button_up():
	emit_signal("button_selected")

func play_turn():
	yield(self, "button_selected")
	Global.dialogue_box.show_comment(['You did something!'], false)
	yield(Global.dialogue_box, "comment_done")
