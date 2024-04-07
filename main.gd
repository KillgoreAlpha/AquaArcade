extends Node2D
# Hi, Matthew here
# This is the Node that holds all of the elements in the game. Some scenes might be instantiated separately,
# but they'll all be united here. The primary game scripts should be written here

var time = 0
var season = 0
var year = 0

var water = 0.5
var pollution = 0.0
var water_quality = 1

var mountain = 10000
var snow = 0.5
var metal = 0

var ampears = 0
var ampears_produced = 0
var ampear_quality = 1.0
var ampear_groves = 1

var bots = 1
var productivity = 1.0

var win_progress = 0
var difficulty = 100

# Win Condition Modifier
var winmod = 0
# Win Condition Difficulty Modifier
var windiffmod = 0
# Water Modifier
var watermod = 0
# Pollution Modifier
var pollutionmod = 0
# Water Quality Modifier
var waterqualmod = 0
# Mountain Modifier
var mountainmod = 0
# Snow Modifier
var snowmod = 0
# Metal Modifier
var metalmod = 0
# Ampear Modifier
var ampearmod = 0
# Ampear Quality Modifier
var ampearqualmod = 0
# Ampears Produced Modifier
var ampearprodmod = 0
# Ampear Grove Modifier
var grovemod = 0
# Bots Modifier
var botsmod = 0
# Productivity Modifier
var prodmod = 0
# 
var possibilities

var clocksummer = preload("res://assets/icons/clocksummer.png")
var clockfall = preload("res://assets/icons/clockfall.png")
var clockwinter = preload("res://assets/icons/clockwinter.png")
var clockspring = preload("res://assets/icons/clockspring.png")

var event = preload("res://Event.gd")

func _process(delta):
	season = time % 4
	year = time / 4
	water_quality = ((water - (water * pollution)) / water) + waterqualmod
	ampear_quality = water_quality + ampearqualmod
	productivity = (ampear_quality + water_quality) / 2 + prodmod
	$CanvasLayer/TopBar/WinProgress/MarginContainer/ProgressBar.value = win_progress
	$CanvasLayer/TopBar/ResourceTracker/ResourceContainer/MarginContainer/VFlowContainer/WaterUIGrid/WaterLabel.text = str(water*100) + "%"
	$CanvasLayer/TopBar/ResourceTracker/ResourceContainer/MarginContainer/VFlowContainer/MountainUIGrid/MountainLabel.text = str(snow*100) + "%"
	$CanvasLayer/TopBar/ResourceTracker/ResourceContainer/MarginContainer/VFlowContainer/MetalUIGrid/MetalLabel.text = str(metal)
	$CanvasLayer/TopBar/ResourceTracker/ResourceContainer/MarginContainer/VFlowContainer/AmpearUIGrid/AmpearLabel.text = str(ampears)
	$CanvasLayer/TopBar/ResourceTracker/ResourceContainer/MarginContainer/VFlowContainer/BotsUIGrid/BotsLabel.text = str(bots)
	$CanvasLayer/TopBar/ResourceTracker/ResourceContainer/MarginContainer/VFlowContainer/BotsUIGrid.tooltip_text = "Productivity: " + str(productivity*100)  + "%"
	$CanvasLayer/TopBar/ResourceTracker/ResourceContainer/MarginContainer/VFlowContainer/WaterUIGrid.tooltip_text = "Pollution: " + str(pollution*100)  + "%\n" + "Water Quality: " + str(water_quality*100)  + "%" 
	$CanvasLayer/TopBar/ResourceTracker/ResourceContainer/MarginContainer/VFlowContainer/MountainUIGrid.tooltip_text = "Snow Pack: " + str(productivity*100)  + "%"
	$CanvasLayer/TopBar/ResourceTracker/ResourceContainer/MarginContainer/VFlowContainer/AmpearUIGrid.tooltip_text = "Ampear Groves: " + str(ampear_groves)  + "\n" + "Ampear Quality: " + str(ampear_quality*100)  + "%"
	$CanvasLayer/TopBar/ResourceTracker/ResourceContainer/MarginContainer/VFlowContainer/MetalUIGrid.tooltip_text = "Metal Left: " + str(mountain)
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
	pollution += pollutionmod
	ampear_groves += grovemod
	bots += botsmod
	water += watermod
	mountain -= (bots * productivity) + mountainmod
	ampears_produced = (bots * productivity) * ampear_groves + ampearprodmod
	ampears +=  ampears_produced - bots + ampearmod
	difficulty += windiffmod
	win_progress += ((bots * productivity)/difficulty) + winmod
	if season == 3:
		$CanvasLayer/TopBar/ClockContainer/Clock/ClockBell.play()
		$CanvasLayer/Choices.show()
	else:
		$CanvasLayer/TopBar/ClockContainer/Clock/ClockTick.play()
		
	
