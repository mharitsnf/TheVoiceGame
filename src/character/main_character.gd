extends Battler
class_name MainCharacter

signal button_selected
signal process_completed

var current_action := ''

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
			action_result.action = 'attack'
			if Calculation.calculate_probability(stats.affinity):
				current_action = 'attack'
				action_result.success = true
			else:
				action_result.success = false
				
		'Defend':
			action_result.action = 'defend'
			if Calculation.calculate_probability(stats.affinity):
				current_action = 'defense'
				action_result.success = true
			else:
				action_result.success = false
				
		'Items':
			action_result.action = 'heal'
			if Calculation.calculate_probability(stats.affinity):
				current_action = 'heal'
				action_result.success = true
			else:
				action_result.success = false
				
	emit_signal("button_selected")
	
func process_action():
	match action_result.action:
		'attack':
			if action_result.success:
				var attack_result = enemy.stats.receive_damage(stats.damage)
				
				action_result.enemy_dead = attack_result[0]
				action_result.info['damage_dealt'] = attack_result[2]
				
				Global.enemy_health_bar.update_health_bar(attack_result[1], 'damage')
				Global.enemy_sprite.receive_damage()
				
			else:
				action_result.enemy_dead = false
			
		'defend':
			if action_result.success:
				stats.enhance_defense()
				action_result.enemy_dead = false
			else:
				action_result.enemy_dead = false
			
		'heal':
			if action_result.success:
				var amount = stats.max_health * 0.25
				stats.heal(amount)
				Global.health_bar.update_health_bar(stats.current_health, 'heal')
				action_result.enemy_dead = false
			else:
				action_result.enemy_dead = false
				
	yield(get_tree(), "idle_frame")
		
		
func show_prompt_dialogue():
	match action_result.action:
		'attack':
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
				
		'defend':
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
			
		'heal':
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
		'attack':
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
				
		'defend':
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
				
		'heal':
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

func play_turn():
	print(stats.get_stats())
	if current_action == 'defense':
		stats.revert_defense()
		current_action = ''
	
	# Wait for button selection
	yield(self, "button_selected")
	get_tree().call_group('btns', 'toggle_button', true)
	
	yield(show_prompt_dialogue(), "completed")
	
	yield(process_action(), "completed")
	
	yield(show_result_dialogue(), "completed")
	
	if action_result.enemy_dead:
		reset_action_result()
		return true
	else:
		reset_action_result()
		return false
