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
	ITEMS
}

export var stats : Resource

onready var parent = get_parent()

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
