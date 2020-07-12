extends Battler
class_name Enemy

var target : Battler

func _ready():
	assert(stats != null)
	role = roles.ENEMY
	target = Global.player_node
	
func attack():
	action_result.action = 'attack'
	action_result.success = true
	
	if action_result.success:
		var damage_result = target.stats.receive_damage(stats.damage)
		action_result.enemy_dead = damage_result[0]
		action_result.info['damage_dealt'] = damage_result[2]
		
		Global.health_bar.update_health_bar(damage_result[1], 'damage')
		Global.combat_hud.receive_damage()
	else:
		action_result.enemy_dead = false
	
func defend():
	pass
	
func heal():
	pass

func decide_action():
	return actions.ATTACK

func play_turn():
	yield(get_tree().create_timer(2), "timeout")
	
	match decide_action():
		actions.ATTACK:
			attack()
			if action_result.success:
				Global.dialogue_box.show_comment(
					[
						{"name": "Narrator", "text": 'Bob received %s damage!' % action_result.info['damage_dealt']}
					], 
					false)
				
			else:
				Global.dialogue_box.show_comment(
					[
						{"name": "Voice", "text": 'He did nothing...'},
						{"name": "Bob", "text": 'Oh well...'}
					],
					false)
				
				
		actions.DEFEND:
			defend()
			if action_result.success:
				Global.dialogue_box.show_comment(
					[
						{"name": "Narrator", "text": 'The enemy defended!'}
					], 
					false)
				
			else:
				Global.dialogue_box.show_comment(
					[
						{"name": "Voice", "text": 'He did nothing...'},
						{"name": "Bob", "text": 'Oh well...'}
					],
					false)
				
		actions.ITEMS:
			heal()
			if action_result.success:
				Global.dialogue_box.show_comment(
					[
						{"name": "Narrator", "text": 'The enemy heal himself!'}
					], 
					false)
				
			else:
				Global.dialogue_box.show_comment(
					[
						{"name": "Voice", "text": 'He did nothing...'},
						{"name": "Bob", "text": 'Oh well...'}
					],
					false)
			
			
	yield(Global.dialogue_box, "comment_done")
	
	if action_result.enemy_dead:
		reset_action_result()
		return true
	else:
		reset_action_result()
		return false
