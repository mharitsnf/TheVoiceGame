extends Node2D
class_name TurnQueue

var active_character: Battler
var turn := 0

func initialize():
	active_character = get_child(0)
	play_turn()

func play_turn():
	if active_character.role == Battler.roles.PLAYER and turn != 0:
		Global.dialogue_box.show_comment(['Come on, do something...'], true)
		yield(Global.dialogue_box, "comment_done")
	elif active_character.role == Battler.roles.ENEMY:
		Global.dialogue_box.show_comment(["Enemy's turn..."], true)
		yield(Global.dialogue_box, "comment_done")
		
	if active_character.role == Battler.roles.PLAYER:
		get_tree().call_group('btns', 'toggle_button', false)
		
	var character_dead = yield(active_character.play_turn(), 'completed')
	print('player is ded ' + str(character_dead))
	
	if character_dead:
		print('sedap')
	else:
		next_turn()

func next_turn():
	var new_index : int = (active_character.get_index() + 1) % get_child_count()
	active_character = get_child(new_index)
	turn += 1
	play_turn()
