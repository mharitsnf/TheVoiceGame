extends Battler
class_name MainCharacter

signal button_selected
signal process_completed

var enemy
onready var combat_dialogue = Global.parse_json_file("res://assets/texts/action_dialogues.json")

func _ready():
	assert(stats != null)
	randomize()
	role = roles.PLAYER
	enemy = Global.enemy_node
	
func _combat_button_up(button_name):
	match button_name:
		'Attack':
			action_result.action = actions.ATTACK
			if Calculation.calculate_probability(stats.affinity):
				current_action = actions.ATTACK
				action_result.success = true
			else:
				action_result.success = false
				
		'Defend':
			action_result.action = actions.DEFEND
			if Calculation.calculate_probability(stats.affinity):
				current_action = actions.DEFEND
				action_result.success = true
			else:
				action_result.success = false
				
		'Items':
			action_result.action = actions.HEAL
			if Calculation.calculate_probability(stats.affinity):
				current_action = actions.HEAL
				action_result.success = true
			else:
				action_result.success = false
				
	emit_signal("button_selected")
	
func process_action():
	match action_result.action:
		actions.ATTACK:
			if action_result.success:
				var attack_result = enemy.stats.receive_damage(stats.damage)
				
				action_result.enemy_dead = attack_result[0]
				action_result.info['damage_dealt'] = attack_result[2]
				
				Global.enemy_health_bar.update_health_bar(attack_result[1], 'damage')
				Global.enemy_sprite.receive_damage()
				
			else:
				action_result.enemy_dead = false
			
		actions.DEFEND:
			if action_result.success:
				stats.enhance_defense()
				Global.combat_hud.activate_def_sign()
				action_result.enemy_dead = false
			else:
				action_result.enemy_dead = false
			
		actions.HEAL:
			if action_result.success:
				var amount = stats.max_health * 0.25
				var heal_result = stats.heal(amount)
				
				if !heal_result:
					Global.dialogue_box.show_comment(
						[{"name": "Bob", "text": "I don't have any potions left!"}], 
						false
					)
					yield(Global.dialogue_box, "comment_done")
					
				else:
					Global.health_bar.update_health_bar(stats.current_health, 'heal')
					
				action_result.enemy_dead = false
			else:
				action_result.enemy_dead = false
				
	yield(get_tree(), "idle_frame")
		
		
func show_prompt_dialogue():
	match action_result.action:
		actions.ATTACK:
			Global.dialogue_box.show_comment(
				combat_dialogue.attack.prompt[randi()%combat_dialogue.attack.prompt.size()], 
				false
			)
			yield(Global.dialogue_box, "comment_done")
			
			if action_result.success:
				Global.dialogue_box.show_comment(
					combat_dialogue.attack.success[randi()%combat_dialogue.attack.success.size()], 
					false
				)
			else:
				Global.dialogue_box.show_comment(
					combat_dialogue.attack.failed[randi()%combat_dialogue.attack.failed.size()], 
					false
				)
				
		actions.DEFEND:
			Global.dialogue_box.show_comment(
				combat_dialogue.defend.prompt[randi()%combat_dialogue.defend.prompt.size()], 
				false
			)
			yield(Global.dialogue_box, "comment_done")
			
			if action_result.success:
				Global.dialogue_box.show_comment(
					combat_dialogue.defend.success[randi()%combat_dialogue.defend.success.size()], 
					false
				)
			else:
				Global.dialogue_box.show_comment(
					combat_dialogue.defend.failed[randi()%combat_dialogue.defend.failed.size()], 
					false
				)
			
		actions.HEAL:
			Global.dialogue_box.show_comment(
				combat_dialogue.heal.prompt[randi()%combat_dialogue.heal.prompt.size()], 
				false
			)
			yield(Global.dialogue_box, "comment_done")
			
			if action_result.success:
				Global.dialogue_box.show_comment(
					combat_dialogue.heal.success[randi()%combat_dialogue.heal.success.size()], 
					false
				)
			else:
				Global.dialogue_box.show_comment(
					combat_dialogue.heal.failed[randi()%combat_dialogue.heal.failed.size()], 
					false
				)
	
	yield(Global.dialogue_box, "comment_done")
	
func show_result_dialogue():
	match action_result.action:
		actions.ATTACK:
			if action_result.success:
				Global.dialogue_box.show_comment(
					[{"name": "Narrator", "text": 'Bob dealt %s damage!' % action_result.info['damage_dealt']}], 
					false
				)
			else:
				Global.dialogue_box.show_comment(
					[{"name": "Narrator", "text": 'Bob just stands idly...'}], 
					false
				)
				
		actions.DEFEND:
			if action_result.success:
				Global.dialogue_box.show_comment(
					[{"name": "Narrator", "text": 'Bob defended! His defense doubled!'}], 
					false
				)
			else:
				Global.dialogue_box.show_comment(
					[{"name": "Narrator", "text": 'Bob just stands idly...'}], 
					false
				)
				
		actions.HEAL:
			if action_result.success:
				Global.dialogue_box.show_comment(
					[{"name": "Narrator", "text": 'Bob healed for %s!' % (stats.max_health * 0.25)}], 
					false
				)
			else:
				Global.dialogue_box.show_comment(
					[{"name": "Narrator", "text": 'Bob just stands idly...'}], 
					false
				)
				
	yield(Global.dialogue_box, "comment_done")

func decide_actions_other_than(except_action):
	var actions = ['']

func play_turn():
	if current_action == actions.DEFEND:
		stats.revert_defense()
		Global.combat_hud.deactivate_def_sign()
		
	current_action = -1
	
	# Wait for button selection
	yield(self, "button_selected")
	get_tree().call_group('btns', 'toggle_button', true)
	
	yield(show_prompt_dialogue(), "completed")
	
	yield(process_action(), "completed")
	
	yield(show_result_dialogue(), "completed")
	
	if action_result.enemy_dead:
		reset_action_result()
		return create_turn_state(true, current_action == actions.DEFEND)
	else:
		reset_action_result()
		return create_turn_state(false, current_action == actions.DEFEND)
