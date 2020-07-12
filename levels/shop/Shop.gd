extends Node2D

var arr_choices = [0, 1, 2, 3, 4, 5]

onready var shop_dialogues = Global.parse_json_file("res://assets/texts/shop.json")
var prompt = shop_dialogues.buy.prompt
var failed = shop_dialogues.buy.failed
var success = shop_dialogues.buy.success

func _ready():
	randomize()
	arr_choices.shuffle()
	print(arr_choices)

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
	var image_path = ""
	
	match index:
		0:
			print("Pedang")
			image_path = "res://assets/card_attack.png"
		1:
			print("Perisai")
			image_path = "res://assets/card_armor.png"
		2:
			print("Health 1")
			image_path = "res://assets/card_apple.png"
		3:
			print("Health 2")
			image_path = "res://assets/card_bread.png"
		4:
			print("Health 3")
			image_path = "res://assets/card_chicken.png"
		5:
			print("Potion")
			image_path = "res://assets/card_potion.png"
		_:
			print("FUNCTION ERROR")
			

	var image = load(image_path)
	
	get_node("Button" + String(location)).disabled = true
	get_node("TextureRect" + String(location)).texture = image
	get_node("AnimationPlayer" + String(location)).play("fade_out")
