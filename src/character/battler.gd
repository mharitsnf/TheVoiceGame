extends Node
class_name Battler

enum roles {
	ENEMY
	PLAYER
}
var role

enum actions {
	ATTACK
	DEFEND
	HEAL
}

export var stats : Resource

onready var parent = get_parent()
var current_action = -1

var action_result = {
	'action': '',
	'success': true,
	'enemy_dead': false,
	'info': {}
}

func play_turn():
	pass
	
func reset_action_result():
	action_result = {
		'action': '',
		'success': true,
		'enemy_dead': false,
		'info': {}
	}
	
func create_turn_state(enemy_dead, defense_up):
	return {
		'enemy_dead': enemy_dead,
		'defense_up': defense_up
	}
