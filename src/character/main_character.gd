extends Battler
class_name MainCharacter

signal button_selected

func _attack_button_up():
	print('attack')
	emit_signal("button_selected")

func _defend_button_up():
	print('defend')
	emit_signal("button_selected")
	
func _items_button_up():
	print('item')
	emit_signal("button_selected")

func play_turn():
	yield(self, "button_selected")
	print('sedap')
