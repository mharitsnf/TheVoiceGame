extends Battler
class_name Enemy

var target : Battler

func _ready():
	assert(stats != null)
	role = roles.ENEMY
	target = Global.player_node
	
func attack():
	action_result.action = actions.ATTACK
	action_result.success = true
	
	if action_result.success:
		current_action = actions.ATTACK
		var damage_result = target.stats.receive_damage(stats.damage)
		action_result.enemy_dead = damage_result[0]
		action_result.info['damage_dealt'] = damage_result[2]
		
		Global.health_bar.update_health_bar(damage_result[1], 'damage')
		Global.combat_hud.receive_damage()
	else:
		action_result.enemy_dead = false
	
func defend():
	action_result.action = actions.DEFEND
	action_result.success = true
	
	if action_result.success:
		current_action = actions.DEFEND
		stats.enhance_defense()
		action_result.enemy_dead = false
	else:
		action_result.enemy_dead = false
	
func heal():
	if action_result.success:
		current_action = actions.HEAL
		stats.heal(stats.max_health * 0.25)
		Global.enemy_health_bar.update_health_bar(stats.current_health, 'heal')
		action_result.enemy_dead = false
	else:
		action_result.enemy_dead = false

func play_turn():
	if current_action == actions.DEFEND:
		stats.revert_defense()
		
	current_action = -1
	
	yield(get_tree().create_timer(2), "timeout")
	
	match Calculation.calculate_probability_battle(stats.attack_prob, stats.defend_prob, stats.items_prob):
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
						{"name": "Narrator", "text": 'The enemy defended! His defense rose!'}
					], 
					false
				)
				
			else:
				Global.dialogue_box.show_comment(
					[
						{"name": "Voice", "text": 'He did nothing...'},
						{"name": "Bob", "text": 'Oh well...'}
					],
					false
				)
				
		actions.HEAL:
			heal()
			if action_result.success:
				Global.dialogue_box.show_comment(
					[
						{"name": "Narrator", "text": 'The enemy heal himself for %s!' % (stats.max_health * 0.25)}
					], 
					false
				)
				
			else:
				Global.dialogue_box.show_comment(
					[
						{"name": "Voice", "text": 'He did nothing...'},
						{"name": "Bob", "text": 'Oh well...'}
					],
					false
				)
			
			
	yield(Global.dialogue_box, "comment_done")
	
	if action_result.enemy_dead:
		reset_action_result()
		return create_turn_state(true, current_action == actions.DEFEND)
	else:
		reset_action_result()
		return create_turn_state(false, current_action == actions.DEFEND)
