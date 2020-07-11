extends Battler
class_name Enemy

func play_turn():
	yield(get_tree().create_timer(2), "timeout")
	print('kelar juga')
