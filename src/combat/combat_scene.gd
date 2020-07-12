#warning-ignore-all:
extends Node2D

var player = preload("res://src/character/MainCharacter.tscn").instance()

var sprite_position = Vector2(896, 448)
var enemy

var initial_dialogue

func _ready():
	enemy = load(Transition.get_param('enemy_scene')).instance()
	
	var sprite = load(Transition.get_param('sprite_scene')).instance()
	sprite.get_node('AnimationPlayer').play('idle')
	sprite.position = sprite_position
	add_child(sprite)
	
	initial_dialogue = Global.parse_json_file(Transition.get_param('intro_script_path'))
	
	Global.player_node = player
	Global.enemy_node = enemy
	Global.enemy_sprite = sprite
	
	start()

func start():
	$BGM.play()
	Global.attack_button = $HUD/HBoxContainer/VBoxContainer/HBoxContainer/Attack
	Global.defend_button = $HUD/HBoxContainer/VBoxContainer/HBoxContainer/Defend
	Global.items_button = $HUD/HBoxContainer/VBoxContainer/HBoxContainer/Items
	Global.dialogue_box = $HUD/HBoxContainer/DialogueBox
	Global.health_bar = $HUD/HBoxContainer/VBoxContainer/HealthBar
	Global.combat_hud = $HUD
	Global.enemy_health_bar = $EnemyHealthBar.get_node("HBoxContainer/HealthBar")
	
	Global.attack_button.add_to_group('btns')
	Global.defend_button.add_to_group('btns')
	Global.items_button.add_to_group('btns')
	
	Global.health_bar.initialize(player.stats.max_health, player.stats.current_health)
	Global.enemy_health_bar.initialize(enemy.stats.max_health, enemy.stats.current_health)
	
	# warning-ignore
	Global.attack_button.connect("button_up", player, '_combat_button_up', [Global.attack_button.name])
	Global.defend_button.connect("button_up", player, '_combat_button_up', [Global.defend_button.name])
	Global.items_button.connect("button_up", player, '_combat_button_up', [Global.items_button.name])

	Global.dialogue_box.show_comment(initial_dialogue, true)
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
