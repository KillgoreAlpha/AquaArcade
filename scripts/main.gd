extends Node2D
# Hi, Matthew here
# This is the Node that holds all of the elements in the game. Some scenes might be instantiated separately,
# but they'll all be united here. The primary game scripts should be written here

var time = 0
var season = 0
var year = 0

var clocksummer = preload("res://assets/icons/clocksummer.png")
var clockfall = preload("res://assets/icons/clockfall.png")
var clockwinter = preload("res://assets/icons/clockwinter.png")
var clockspring = preload("res://assets/icons/clockspring.png")
var event_scene = preload("res://scenes/event_manager.tscn")
var choice_scene = preload("res://scenes/choice.tscn")

func _process(delta):
	if global.win_game == true:
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
	if global.lose_game == true:
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
	season = time % 4
	year = time / 4
	global.water_quality = ((global.water - (global.water * global.pollution)) / global.water) + global.waterqualmod
	global.ampear_quality = global.water_quality + global.ampearqualmod
	global.productivity = (global.ampear_quality + global.water_quality) / 2 + global.prodmod
	$CanvasLayer/TopBar/WinProgress/MarginContainer/ProgressBar.value = global.win_progress
	$CanvasLayer/TopBar/ResourceTracker/ResourceContainer/MarginContainer/VFlowContainer/WaterUIGrid/WaterLabel.text = str(global.water*100) + "%"
	$CanvasLayer/TopBar/ResourceTracker/ResourceContainer/MarginContainer/VFlowContainer/MountainUIGrid/MountainLabel.text = str(global.snow*100) + "%"
	$CanvasLayer/TopBar/ResourceTracker/ResourceContainer/MarginContainer/VFlowContainer/MetalUIGrid/MetalLabel.text = str(global.metal)
	$CanvasLayer/TopBar/ResourceTracker/ResourceContainer/MarginContainer/VFlowContainer/AmpearUIGrid/AmpearLabel.text = str(global.ampears)
	$CanvasLayer/TopBar/ResourceTracker/ResourceContainer/MarginContainer/VFlowContainer/BotsUIGrid/BotsLabel.text = str(global.bots)
	$CanvasLayer/TopBar/ResourceTracker/ResourceContainer/MarginContainer/VFlowContainer/BotsUIGrid.tooltip_text = "Productivity: " + str(global.productivity*100)  + "%"
	$CanvasLayer/TopBar/ResourceTracker/ResourceContainer/MarginContainer/VFlowContainer/WaterUIGrid.tooltip_text = "Pollution: " + str(global.pollution*100)  + "%\n" + "Water Quality: " + str(global.water_quality*100)  + "%" 
	$CanvasLayer/TopBar/ResourceTracker/ResourceContainer/MarginContainer/VFlowContainer/MountainUIGrid.tooltip_text = "Snow Pack: " + str(global.productivity*100)  + "%"
	$CanvasLayer/TopBar/ResourceTracker/ResourceContainer/MarginContainer/VFlowContainer/AmpearUIGrid.tooltip_text = "Ampear Groves: " + str(global.ampear_groves)  + "\n" + "Ampear Quality: " + str(global.ampear_quality*100)  + "%"
	$CanvasLayer/TopBar/ResourceTracker/ResourceContainer/MarginContainer/VFlowContainer/MetalUIGrid.tooltip_text = "Metal Left: " + str(global.mountain)
	match season:
		0:
			$CanvasLayer/TopBar/DateContainer/MarginContainer/CurrentTime.text = "Summer, Year " + str(year)
			$CanvasLayer/TopBar/ClockContainer/Clock.texture = clocksummer
		1:
			$CanvasLayer/TopBar/DateContainer/MarginContainer/CurrentTime.text = "Fall, Year " + str(year)
			$CanvasLayer/TopBar/ClockContainer/Clock.texture = clockfall
		2:
			$CanvasLayer/TopBar/DateContainer/MarginContainer/CurrentTime.text = "Winter, Year " + str(year)
			$CanvasLayer/TopBar/ClockContainer/Clock.texture = clockwinter
		3:
			$CanvasLayer/TopBar/DateContainer/MarginContainer/CurrentTime.text = "Spring, Year " + str(year)
			$CanvasLayer/TopBar/ClockContainer/Clock.texture = clockspring

func _on_end_turn_pressed():
	time += 1
	if global.policy_time > 0:
		global.policy_time -= 1
	else:
		if global.policy1 == true:
			global.metalmod += 2
			global.botsmod -= 1
			global.policy1 = false
		if global.policy2 == true:
			global.prodmod -= 1
			global.policy2 = false
		if global.policy3 == true:
			global.prodmod += 0.5
			global.policy2 = false
	global.pollution += global.pollutionmod
	global.ampear_groves += global.grovemod
	global.bots += global.botsmod
	global.water += global.watermod
	global.mountain -= (global.bots * global.productivity) + global.mountainmod
	global.metal += (global.bots * global.productivity) + global.metalmod
	global.ampears_produced = ((global.bots * global.productivity) * global.ampear_groves) + global.ampearprodmod
	global.ampears +=  global.ampears_produced - global.bots + global.ampearmod
	global.difficulty += global.windiffmod
	global.win_progress += ((global.bots * global.productivity)/global.difficulty) + global.winmod
	if season == 3:
		$CanvasLayer/TopBar/ClockContainer/Clock/ClockBell.play()
		spawn_choice()
	else:
		$CanvasLayer/TopBar/ClockContainer/Clock/ClockTick.play()
		spawn_event()

func spawn_choice():
	var choice_instace = choice_scene.instantiate()
	add_child(choice_instace)

func spawn_event():
	var event_instace = event_scene.instantiate()
	add_child(event_instace)
