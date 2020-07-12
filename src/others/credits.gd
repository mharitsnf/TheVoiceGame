extends Node2D

func _ready():
	$AnimationPlayer.play("roll")
	yield($AnimationPlayer, "animation_finished")
	yield(get_tree().create_timer(3), "timeout")
	Transition.fade_to("res://levels/main_menu/MainMenu.tscn")
