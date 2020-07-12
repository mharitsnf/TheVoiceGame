extends Node2D

onready var intro_dialogue = Global.parse_json_file("res://assets/texts/intro.json")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	start()

func start():
	$DialogueBox.show_comment(intro_dialogue, true)
	yield($DialogueBox, "comment_done")
	
	Transition.fade_to("res://levels/shop/Shop.tscn")
