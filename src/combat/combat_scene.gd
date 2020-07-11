#warning-ignore-all:
extends Node2D

var player = preload("res://src/character/MainCharacter.tscn")
var enemy = preload("res://src/character/Enemy.tscn")

var dialogue_initial_text = ["Lorem ipsum dolor si anjing", 'si anjing cokelat pake susu krim dibekuin', 'FIGHT!!']

func _ready():
	initialize()

func initialize():
#	$AudioStreamPlayer.play()
	Global.attack_button = $HUD/HBoxContainer/VBoxContainer/HBoxContainer/Attack
	Global.defend_button = $HUD/HBoxContainer/VBoxContainer/HBoxContainer/Defend
	Global.items_button = $HUD/HBoxContainer/VBoxContainer/HBoxContainer/Items
	Global.dialogue_box = $HUD/HBoxContainer/DialogueBox
	
	Global.attack_button.add_to_group('btns')
	Global.defend_button.add_to_group('btns')
	Global.items_button.add_to_group('btns')
	
	var player_instance = player.instance()
	player_instance.add_to_group('player')
	var enemy_instance = enemy.instance()
	enemy_instance.add_to_group('enemy')
	
	# warning-ignore
	Global.attack_button.connect("button_up", player_instance, '_combat_button_up', [Global.attack_button.name])
	Global.defend_button.connect("button_up", player_instance, '_combat_button_up', [Global.defend_button.name])
	Global.items_button.connect("button_up", player_instance, '_combat_button_up', [Global.items_button.name])

	Global.dialogue_box.show_comment(dialogue_initial_text, true)
	yield(Global.dialogue_box, "comment_done")
	
	$TurnQueue.add_child(player_instance)
	$TurnQueue.add_child(enemy_instance)
	$TurnQueue.initialize()
