extends Node

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	print(calculate_damage(200,10))
	print(calculate_probability(0.4))

# return damage calculation, Source: https://rpg.fandom.com/wiki/Damage_Formula
func calculate_damage(attack: float, defence: float):
	var damage := floor(attack * (100 / (100 + defence)))
	return int(damage) if damage > 0 else 1

# return whether the action will happen or not
func calculate_probability(probs: float):
	rng.randomize()
	var happened := probs * 10
	var arr_probs := []
	for n in range(10):
		if (n < happened):
		   arr_probs.push_front(1)
		else:
		   arr_probs.push_front(0)
	arr_probs.shuffle()
	var random_index = rng.randi_range(0,9)
	return arr_probs[random_index] == 1
