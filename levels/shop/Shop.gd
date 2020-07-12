extends Node2D

var arr_choices = [0, 1, 2, 3, 4, 5]

func _ready():
	arr_choices.shuffle()

func _on_Button_pressed():
	card_check(arr_choices[0], 1)

func _on_Button2_pressed():
	card_check(arr_choices[1], 2)
	
func _on_Button3_pressed():
	card_check(arr_choices[2], 3)

func _on_Button4_pressed():
	card_check(arr_choices[3], 4)

func _on_Button5_pressed():
	card_check(arr_choices[4], 5)
	
func _on_Button6_pressed():
	card_check(arr_choices[5], 6)

func card_check(index: int, location: int):
	match index:
		0:
			print("Pedang")
		1:
			print("Perisai")
		2:
			print("Health 1")
		3:
			print("Health 2")
		4:
			print("Health 3")
		5:
			print("Potion")
		_:
			print("FUNCTIION ERROR")
	
	get_node("AnimationPlayer" + String(location)).play("play")


