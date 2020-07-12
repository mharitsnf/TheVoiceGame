extends Node2D

func _ready():
	yield(get_tree().create_timer(5), "timeout")
	Transition.fade_to("res://src/others/Credits.tscn")
