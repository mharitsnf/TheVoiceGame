extends Node2D
class_name TurnQueue

var active_character : Battler

func initialize():
	active_character = get_child(0)
	print('here ' + str(active_character))
	play_turn()

func play_turn():
	yield(active_character.play_turn(), 'completed')
	next_turn()

func next_turn():
	var new_index : int = (active_character.get_index() + 1) % get_child_count()
	active_character = get_child(new_index)
	play_turn()
