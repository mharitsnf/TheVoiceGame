#warning-ignore-all:
extends Node2D

var player = preload("res://src/character/MainCharacter.tscn").instance()
var sprite_position = Vector2(544, 352)
var enemy

onready var dialogue_initial_text = Global.parse_json_file("res://assets/texts/experiment.json")

func _ready():
	var sprite
	match SceneSwitcher.get_param('enemy_no'):
		1:
			enemy = load("res://src/character/Enemy.tscn").instance()
			sprite = load("res://src/character/sprites/Chiking.tscn").instance()
			sprite.get_node('AnimationPlayer').play('idle')
			sprite.position = sprite_position
			add_child(sprite)
		2:
			enemy = load("res://src/character/Enemy2.tscn").instance()
			sprite = load("res://src/character/sprites/Human.tscn").instance()
			sprite.get_node('AnimationPlayer').play('idle')
			sprite.position = sprite_position
			add_child(sprite)
		3:
			enemy = load("res://src/character/Enemy3.tscn").instance()
			sprite = load("res://src/character/sprites/Pramexas.tscn").instance()
			sprite.get_node('AnimationPlayer').play('idle')
			sprite.position = sprite_position
			add_child(sprite)
			
	Global.player_node = player
	Global.enemy_node = enemy
	Global.enemy_sprite = sprite
	
	start()

func start():
	$AudioStreamPlayer.play()
	Global.attack_button = $HUD/HBoxContainer/VBoxContainer/HBoxContainer/Attack
	Global.defend_button = $HUD/HBoxContainer/VBoxContainer/HBoxContainer/Defend
	Global.items_button = $HUD/HBoxContainer/VBoxContainer/HBoxContainer/Items
	Global.dialogue_box = $HUD/HBoxContainer/DialogueBox
	Global.health_bar = $HUD/HBoxContainer/VBoxContainer/HealthBar
	Global.combat_hud = $HUD
	
	Global.attack_button.add_to_group('btns')
	Global.defend_button.add_to_group('btns')
	Global.items_button.add_to_group('btns')
	
	Global.attack_button.add_to_group('btns')
	Global.defend_button.add_to_group('btns')
	Global.items_button.add_to_group('btns')
	
	var player_instance = player.instance()
	player_instance.add_to_group('player')
	var enemy_instance = enemy.instance()
	enemy_instance.add_to_group('enemy')
	
	Global.health_bar.initialize(player.stats.max_health, player.stats.current_health)
	
	Global.health_bar.initialize(player_instance.stats.max_health, player_instance.stats.current_health)
	
	# warning-ignore
	Global.attack_button.connect("button_up", player, '_combat_button_up', [Global.attack_button.name])
	Global.defend_button.connect("button_up", player, '_combat_button_up', [Global.defend_button.name])
	Global.items_button.connect("button_up", player, '_combat_button_up', [Global.items_button.name])

	Global.dialogue_box.show_comment(dialogue_initial_text, true)
	yield(Global.dialogue_box, "comment_done")
	
	$TurnQueue.add_child(player)
	$TurnQueue.add_child(enemy)
	$TurnQueue.initialize()
	
func clear_globals():
	Global.attack_button.disconnect("button_up", player, '_combat_button_up')
	Global.defend_button.disconnect("button_up", player, '_combat_button_up')
	Global.items_button.disconnect("button_up", player, '_combat_button_up')
	
	Global.attack_button = null
	Global.defend_button = null
	Global.items_button = null
	Global.dialogue_box = null
	Global.health_bar = null
	Global.combat_hud = null
	
	Global.player_node = null
	Global.enemy_node = null
	Global.enemy_sprite = null
