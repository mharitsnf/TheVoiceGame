extends Resource
class_name CharacterStats

export var max_health := 1 
export var current_health := 1
export var strength := 1
export var defense := 1
export var damage := 1

func receive_damage(damage):
	current_health -= damage
	var is_dead = false if current_health > 0 else true
	return [is_dead, current_health]
