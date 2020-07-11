extends Battler
class_name MainCharacter

signal button_selected
signal process_completed

var is_target_dead = null
var current_action := ''

func _ready():
	assert(stats != null)
	role = roles.PLAYER
	
func _combat_button_up(button_name):
	emit_signal("button_selected")
	
	match button_name:
		'Attack':
			print('attack')
			is_target_dead = false
			current_action = 'attack'
		'Defend':
			print('defend')
			is_target_dead = false
			current_action = 'defend'
		'Items':
			print('items')
			is_target_dead = false
			current_action = 'heal'
	
	emit_signal("process_completed")

func play_turn():
	# Wait for button selection
	yield(self, "button_selected")
	get_tree().call_group('btns', 'toggle_button', true)
	yield(self, "process_completed")
	
	if is_target_dead:
		parent.emit_signal("end_combat")
	else:
		Global.dialogue_box.show_comment(['You %sed! Congratulations!' % current_action], false)
		yield(Global.dialogue_box, "comment_done")
	
	current_action = ''
	is_target_dead = null
