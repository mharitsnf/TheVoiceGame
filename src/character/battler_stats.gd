extends Resource
class_name CharacterStats

export var health := 1 
export var strength := 1
export var defense := 1
export var damage := 1

func receive_damage(damage):
	health -= damage
	return false if health > 0 else true
