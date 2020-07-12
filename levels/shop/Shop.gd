extends Node2D

signal step_done

var arr_choices = [0, 1, 2, 3, 4, 5]
var wishlist = [0, 1, 2, 3, 4, 5]

var player_stats = preload("res://src/character/stats/PlayerStats.tres")
var game_state = preload("res://src/game state/GameState.tres")

onready var shop_dialogues = Global.parse_json_file("res://assets/texts/shop.json")
onready var initial_dialogue = Global.parse_json_file("res://assets/texts/shop_initial.json")

var prompt
var failed
var success
var wish := 0

# HARDCODE
var number_of_actions := 6

func _ready():
	randomize()
	print([game_state.enemies_won, game_state.current_attempt])
	$Button1.add_to_group('cards')
	$Button2.add_to_group('cards')
	$Button3.add_to_group('cards')
	$Button4.add_to_group('cards')
	$Button5.add_to_group('cards')
	$Button6.add_to_group('cards')
	disable_buttons()
	
	arr_choices.shuffle()
	prompt = shop_dialogues.buy.prompt
	failed = shop_dialogues.buy.failed
	success = shop_dialogues.buy.success
	
	if !game_state.first_shop_done:
		yield(initial_dialogue(), "completed")
		game_state.first_shop_done = true
	
	show_dialog()
	
func initial_dialogue():
	$DialogueBox.show_comment(initial_dialogue, false)
	yield($DialogueBox, "comment_done")
	
func show_dialog():
	for i in number_of_actions:
		randomize()
		wish = wishlist[randi() % wishlist.size()]
		
		var wish_dialogue = [prompt[wish]]
		wish_dialogue.push_back({'name': 'Bob', 'text': "Why don't you pick one of the cards then?"})
		
		$DialogueBox.show_comment(wish_dialogue, true)
		yield($DialogueBox, "comment_done")
		
		enable_buttons()
		yield(self, "step_done")
		
		disable_buttons()
		yield(self, "step_done")
		
		wishlist.remove(wish)
		
	continue_to_combat()
		

func _on_Button_pressed():
	card_check(arr_choices[0], 1)
	emit_signal("step_done")

func _on_Button2_pressed():
	card_check(arr_choices[1], 2)
	emit_signal("step_done")
	
func _on_Button3_pressed():
	card_check(arr_choices[2], 3)
	emit_signal("step_done")

func _on_Button4_pressed():
	card_check(arr_choices[3], 4)
	emit_signal("step_done")

func _on_Button5_pressed():
	card_check(arr_choices[4], 5)
	emit_signal("step_done")

func _on_Button6_pressed():
	card_check(arr_choices[5], 6)
	emit_signal("step_done")

func card_check(index: int, location: int):
	remove_child(get_node("Button" + str(location)))
	
	var image_path = ""
	match index:
		0:
			image_path = "res://assets/card_attack.png"
		1:
			image_path = "res://assets/card_armor.png"
		2:
			image_path = "res://assets/card_apple.png"
		3:
			image_path = "res://assets/card_bread.png"
		4:
			image_path = "res://assets/card_chicken.png"
		5:
			image_path = "res://assets/card_potion.png"
	var image = load(image_path)
	get_node("TextureRect" + str(location)).texture = image
	get_node("AnimationPlayer").play("fade out " + str(location))
			
	yield(wish_check(index), "completed")
	add_effects(index)
	
	emit_signal("step_done")

func add_effects(index : int):
	match index:
		0:
			player_stats.damage += 5
		1:
			player_stats.defense += 5
		2:
			player_stats.eat_food(10)
		3:
			player_stats.eat_food(20)
		4:
			player_stats.eat_food(30)
		5:
			player_stats.potion_count += 1
			
	print([player_stats.damage, player_stats.defense, player_stats.max_health, player_stats.current_health, player_stats.potion_count])

func wish_check(expected: int):
	match expected:
		0:
			if (wish == 0):
				player_stats.affinity += 0.25
				$DialogueBox.show_comment([success[wish]], false)
				yield($DialogueBox, "comment_done")
			else:
				player_stats.affinity -= 0.05
				$DialogueBox.show_comment([failed[wish]], false)
				yield($DialogueBox, "comment_done")
		1:
			if (wish == 1):
				player_stats.affinity -= 0.25
				$DialogueBox.show_comment([success[wish]], false)
				yield($DialogueBox, "comment_done")
			else:
				player_stats.affinity += 0.05
				$DialogueBox.show_comment([failed[wish]], false)
				yield($DialogueBox, "comment_done")
		2:
			if (wish == 2):
				player_stats.affinity += 0.25
				$DialogueBox.show_comment([success[wish]], false)
				yield($DialogueBox, "comment_done")
			else:
				player_stats.affinity -= 0.05
				$DialogueBox.show_comment([failed[wish]], false)
				yield($DialogueBox, "comment_done")
		_:
			if (wish == 3 || wish == 4 || wish == 5):
				player_stats.affinity += 0.25
				$DialogueBox.show_comment([success[wish]], false)
				yield($DialogueBox, "comment_done")
			else:
				player_stats.affinity -= 0.05
				$DialogueBox.show_comment([failed[wish]], false)
				yield($DialogueBox, "comment_done")

func disable_buttons():
	get_tree().call_group('cards', 'set_disabled', true)
	
func enable_buttons():
	get_tree().call_group('cards', 'set_disabled', false)

func continue_to_combat():
	match game_state.enemies_won:
		0:
			Transition.fade_to(
				"res://src/combat/CombatScene.tscn",
				{
					'intro_script_path': "res://assets/texts/chiking_intro.json",
					'outro_script_path': "res://assets/texts/chiking_intro.json",
					'enemy_scene': "res://src/character/Enemy.tscn",
					'sprite_scene': "res://src/character/sprites/Chiking.tscn"
				}
			)
		1:
			Transition.fade_to(
				"res://src/combat/CombatScene.tscn",
				{
					'intro_script_path': "res://assets/texts/introRoy.json",
					'outro_script_path': "res://assets/texts/introRoy.json",
					'enemy_scene': "res://src/character/Enemy2.tscn",
					'sprite_scene': "res://src/character/sprites/Human.tscn"
				}
			)
		2:
			Transition.fade_to(
				"res://src/combat/CombatScene.tscn",
				{
					'intro_script_path': "res://assets/texts/introDovic.json",
					'outro_script_path': "res://assets/texts/introDovic.json",
					'enemy_scene': "res://src/character/Enemy3.tscn",
					'sprite_scene': "res://src/character/sprites/Pramexas.tscn"
				}
			)
