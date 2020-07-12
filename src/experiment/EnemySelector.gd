extends Control

var combat_scene = preload("res://src/combat/CombatScene.tscn")

func _ready():
	$VBoxContainer/HBoxContainer/Button.connect("button_up", self, '_on_button_up', [$VBoxContainer/HBoxContainer/Button.name])
	$VBoxContainer/HBoxContainer/Button2.connect("button_up", self, '_on_button_up', [$VBoxContainer/HBoxContainer/Button2.name])
	$VBoxContainer/HBoxContainer/Button3.connect("button_up", self, '_on_button_up', [$VBoxContainer/HBoxContainer/Button3.name])

func _on_button_up(btn_name):
	match btn_name:
		'Button':
			SceneSwitcher.change_scene(
				"res://src/combat/CombatScene.tscn",
				{
					'intro_script_path': "res://assets/texts/chiking_intro.json",
					'outro_script_path': "res://assets/texts/chiking_intro.json",
					'enemy_scene': "res://src/character/Enemy.tscn",
					'sprite_scene': "res://src/character/sprites/Chiking.tscn"
				}
			)
		'Button2':
			SceneSwitcher.change_scene(
				"res://src/combat/CombatScene.tscn",
				{
					'intro_script_path': "res://assets/texts/introRoy.json",
					'outro_script_path': "res://assets/texts/introRoy.json",
					'enemy_scene': "res://src/character/Enemy2.tscn",
					'sprite_scene': "res://src/character/sprites/Human.tscn"
				}
			)
		'Button3':
			SceneSwitcher.change_scene(
				"res://src/combat/CombatScene.tscn",
				{
					'intro_script_path': "res://assets/texts/introDovic.json",
					'outro_script_path': "res://assets/texts/introDovic.json",
					'enemy_scene': "res://src/character/Enemy3.tscn",
					'sprite_scene': "res://src/character/sprites/Pramexas.tscn"
				}
			)
			
