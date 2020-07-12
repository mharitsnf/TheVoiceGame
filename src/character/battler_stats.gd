extends Resource
class_name CharacterStats

export var max_health := 1 
export var current_health := 1
export var defense := 1
export var damage := 1

func receive_damage(received_damage):
	var damage_dealt = Calculation.calculate_damage(received_damage, defense)
	current_health -= damage_dealt
	var is_dead = false if current_health > 0 else true
	return [is_dead, current_health, damage_dealt]

func enhance_defense():
	self.defense *= 20
	
func revert_defense():
	self.defense /= 20
	
func enhance_stats(stat, value):
	match stat:
		'defense': defense += value
		'damage': damage += value
		
func get_stats():
	return {
		'max_health': max_health,
		'current_health': current_health,
		'defense': defense,
		'damage': damage
	}
