extends Sprite

func receive_damage():
	modulate = Color.red
	$Tween.interpolate_property(self, 'position', position, position + Vector2(20, 0), 0.1)
	$Tween.start()
	yield($Tween, "tween_all_completed")
	
	$Tween.interpolate_property(self, 'position', position, position - Vector2(20, 0), 0.1)
	$Tween.start()
	yield($Tween, "tween_all_completed")
	
	$Tween.interpolate_property(self, 'position', position, position + Vector2(20, 0), 0.1)
	$Tween.start()
	yield($Tween, "tween_all_completed")
	
	$Tween.interpolate_property(self, 'position', position, position - Vector2(20, 0), 0.1)
	$Tween.start()
	yield($Tween, "tween_all_completed")
	modulate = Color.white
