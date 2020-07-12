extends Control

var combat_scene = preload("res://src/combat/CombatScene.tscn")

func _ready():
	$VBoxContainer/HBoxContainer/Button.connect("button_up", self, '_on_button_up', [$VBoxContainer/HBoxContainer/Button.name])
	$VBoxContainer/HBoxContainer/Button2.connect("button_up", self, '_on_button_up', [$VBoxContainer/HBoxContainer/Button2.name])
	$VBoxContainer/HBoxContainer/Button3.connect("button_up", self, '_on_button_up', [$VBoxContainer/HBoxContainer/Button3.name])

func _on_button_up(btn_name):
	match btn_name:
		'Button':
			SceneSwitcher.change_scene("res://src/combat/CombatScene.tscn", {'enemy_no': 1})
		'Button2':
			SceneSwitcher.change_scene("res://src/combat/CombatScene.tscn", {'enemy_no': 2})
		'Button3':
			SceneSwitcher.change_scene("res://src/combat/CombatScene.tscn", {'enemy_no': 3})
			
