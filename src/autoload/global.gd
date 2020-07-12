extends Node

var attack_button : TextureButton
var defend_button : TextureButton
var items_button : TextureButton

var player_node : Battler
var enemy_node : Battler
var enemy_sprite : Sprite

var dialogue_box : Control

var health_bar : Control
var combat_hud : Control

var enemy_health_bar : Control

func parse_json_file(path):
	var file = File.new()
	file.open(path, file.READ)
	var json = file.get_as_text()
	var json_result = JSON.parse(json).result
	file.close()
	return json_result
