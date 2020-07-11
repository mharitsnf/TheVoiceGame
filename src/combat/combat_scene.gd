extends Node2D

var player = preload("res://src/character/MainCharacter.tscn")
var enemy = preload("res://src/character/Enemy.tscn")

func _ready():
	Global.attack_button = $Control/VBoxContainer/HBoxContainer/Attack
	Global.defend_button = $Control/VBoxContainer/HBoxContainer/Defend
	Global.items_button = $Control/VBoxContainer/HBoxContainer/Items
	
	var player_instance = player.instance()
	
	Global.attack_button.connect("button_up", player_instance, '_attack_button_up')
	Global.defend_button.connect("button_up", player_instance, '_defend_button_up')
	Global.items_button.connect("button_up", player_instance, '_items_button_up')
	
	var enemy_instance = enemy.instance()
	
	$TurnQueue.add_child(player_instance)
	$TurnQueue.add_child(enemy_instance)
	$TurnQueue.initialize()
