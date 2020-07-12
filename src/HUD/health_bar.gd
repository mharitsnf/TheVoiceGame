extends Control

onready var health_bar := $TextureProgress

func initialize(max_health, current_health):
	health_bar.max_value = max_health
	health_bar.value = current_health

func update_health_bar(new_health, type):
	health_bar.value = new_health
	if type == 'damage':
		$Hurt.play()
