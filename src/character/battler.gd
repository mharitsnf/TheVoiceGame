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

func play_turn():
	pass
