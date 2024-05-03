extends Node2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready():
	pass

func _on_choice_1_pressed():
	global.policy1 = true
	global.metalmod -= 1
	global.botsmod += 1
	global.policy_time = 3
	queue_free()

func _on_choice_2_pressed():
	global.policy2 = true
	global.prodmod += 1
	global.pollutionmod += .05
	global.policy_time = 3
	queue_free()

func _on_choice_3_pressed():
	global.policy3 = true
	global.prodmod -= 0.5
	global.pollutionmod -= .1
	global.policy_time = 3
	queue_free()
