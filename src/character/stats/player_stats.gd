extends CharacterStats
class_name PlayerStats

export var affinity := 0.4 setget set_affinity
export var potion_count := 1

func set_affinity(value):
	affinity = value

func eat_food(amount):
	current_health += amount
	if current_health > max_health:
		max_health = current_health
		
func heal(value):
	if potion_count > 0:
		current_health += value
		if current_health > max_health:
			current_health = max_health
		potion_count -= 1
		return current_health
	return false
