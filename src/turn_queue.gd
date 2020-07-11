extends Node2D
class_name TurnQueue

var active_character : Battler
var turn := 0

func initialize():
	active_character = get_child(0)
	print('here ' + str(active_character))
	play_turn()

func play_turn():
	print(turn)
	
	if active_character.role == Battler.roles.PLAYER and turn != 0:
		Global.dialogue_box.show_comment(['Come on, do something...'], true)
		yield(Global.dialogue_box, "comment_done")
	if active_character.role == Battler.roles.ENEMY:
		Global.dialogue_box.show_comment(["Enemy's turn..."], true)
		yield(Global.dialogue_box, "comment_done")
		
	yield(active_character.play_turn(), 'completed')
	next_turn()

func next_turn():
	var new_index : int = (active_character.get_index() + 1) % get_child_count()
	active_character = get_child(new_index)
	turn += 1
	play_turn()
