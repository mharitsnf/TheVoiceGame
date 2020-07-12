extends Control

func _ready():
	pass # Replace with function body.

func _on_TextureButton_pressed():
	Transition.fade_to("res://levels/intro/Intro.tscn")
