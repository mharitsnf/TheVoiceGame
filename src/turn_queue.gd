extends Node2D
class_name TurnQueue


signal end_combat

var active_character: Battler
var turn := 0

onready var parent = get_parent()
onready var win_dialogue = Global.parse_json_file("res://assets/texts/win_dialogues.json")

func initialize():
	active_character = get_child(0)
	play_turn()

func play_turn():
	if active_character.role == Battler.roles.PLAYER and turn != 0:
		Global.dialogue_box.show_comment([{"name": "Voice", "text": "Let's see what should you do..."}], true)
		yield(Global.dialogue_box, "comment_done")
	elif active_character.role == Battler.roles.ENEMY:
		Global.dialogue_box.show_comment([{"name": "Voice", "text": "Okay let's wait..."}], true)
		yield(Global.dialogue_box, "comment_done")
		
	if active_character.role == Battler.roles.PLAYER:
		get_tree().call_group('btns', 'toggle_button', false)
		
	var character_dead = yield(active_character.play_turn(), 'completed')
	
	if character_dead:
		combat_finished()
	else:
		next_turn()

func next_turn():
	var new_index : int = (active_character.get_index() + 1) % get_child_count()
	active_character = get_child(new_index)
	turn += 1
	play_turn()
	
func combat_finished():
	if active_character.role == Battler.roles.ENEMY:
		Global.dialogue_box.show_comment([{"name": "Voice", "text": "Haha nooob!!"}], true)
		yield(Global.dialogue_box, "comment_done")
	else:
		Global.dialogue_box.show_comment(
			win_dialogue[randi()%win_dialogue.size()], 
			true
		)
		yield(Global.dialogue_box, "comment_done")
		
	parent.clear_globals()
