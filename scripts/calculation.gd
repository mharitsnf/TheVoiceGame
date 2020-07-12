extends Node

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
#func _ready():
#	print(calculate_damage(200,10))
#	print(calculate_probability(0.4))
#	print(calculate_probability_battle(0.3,0.4,0.3))
#	print(calculate_probability_v2(6))

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

func calculate_probability_v2(choices: int):
	rng.randomize()
	var arr_probs := []
	for n in range(choices):
		arr_probs.push_front(n)
	arr_probs.shuffle()
	var random_index = rng.randi_range(0, choices - 1)
	return arr_probs[random_index]

func calculate_probability_battle(probs_1: float, probs_2: float, probs_3: float):
	rng.randomize()
	var arr_options = [probs_1 * 10, probs_2 * 10, probs_3 * 10]
	var arr_probs = []
	for n in range(10):
		if (n < arr_options[0]):
			arr_probs.push_front(0)
		elif(n < arr_options[0] + arr_options[1]):
			arr_probs.push_front(1)
		else:
			arr_probs.push_front(2)
	arr_probs.shuffle()
	var random_index = rng.randi_range(0,9)
	return arr_probs[random_index]
