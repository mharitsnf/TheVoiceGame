extends Battler
class_name Enemy

var target : Battler

func _ready():
	assert(stats != null)
	role = roles.ENEMY
	target = get_tree().get_nodes_in_group('player')[0]
	
func attack():
	var damage_result = target.stats.receive_damage(stats.damage)
	Global.health_bar.update_health_bar(damage_result[1])
	Global.combat_hud.receive_damage()
	return damage_result[0]
	
func defend():
	return false
	
func heal():
	return false

func decide_action():
	return actions.ATTACK

func play_turn():
	yield(get_tree().create_timer(2), "timeout")
	
	var is_target_dead
	match decide_action():
		actions.ATTACK:
			is_target_dead = attack()
		actions.DEFEND:
			is_target_dead = defend()
		actions.ITEMS:
			is_target_dead = heal()
			
	if is_target_dead:
		return true
	else:
		Global.dialogue_box.show_comment(['You receive %s damage!' % stats.damage], false)
		yield(Global.dialogue_box, "comment_done")
		return false
