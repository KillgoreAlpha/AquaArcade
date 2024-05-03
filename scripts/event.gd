extends Node2D

var eventID
var chosenEvent
var possibleEvents: Array

func _ready():
	chosenEvent = eventSelector()
	eventID = chosenEvent[0]
	$"Sprite2D/Choice Window/Description".text = chosenEvent[1]
	$"Sprite2D/Choice Window/Option 1".text = chosenEvent[2]
	$"Sprite2D/Choice Window/Option 2".text = chosenEvent[3]

func eventSelector():
	possibleEvents = [0, 1, 2, 4, 6, 7, 8, 9, 14]
	# Lubricant Synthesis Events
	if global.synthesizerBuilt == true:
		if global.synthesizerRunning == true:
			possibleEvents.append(11)
		else:
			possibleEvents.append(10)
	else: 
		possibleEvents.append(5)
	# Beacon Events
	if global.beaconProgress > 0:
		if global.beaconProgress > 1 && global.metal >= 1000:
			possibleEvents.append(13)
		elif global.beaconProgress == 1 && global.metal >= 500:
			possibleEvents.append(12)
	if global.beaconProgress == 0 && global.metal >= 100:
		possibleEvents.append(3)
	eventID = possibleEvents.pick_random()
	return global.allEvents[eventID]

func _on_option_1_pressed():
	$"Sprite2D/Choice Window".hide()
	#if eventID == 0:
		#global.
	#if eventID == 1:
		#global.
	#if eventID == 2:
		#global.
	if eventID == 3:
		global.metal -= 100
		global.beaconProgress += 1
		global.win_progress += 10
	#if eventID == 4:
		#global.
	if eventID == 5:
		global.synthesizerBuilt = true
	#if eventID == 6:
		#global.
	#if eventID == 7:
		#global.
	#if eventID == 8:
		#global.
	#if eventID == 9:
		#global.
	if eventID == 10:
		global.synthesizerRunning = true
		global.synthesizerLevel += 1
		global.pollution += 0.1
	if eventID == 11:
		global.synthesizerLevel += 1
		global.pollution += 0.1
	if eventID == 12:
		global.metal -= 500
		global.beaconProgress += 1
		global.win_progress += 20
	if eventID == 13:
		global.metal -= 1000
		global.beaconProgress += 1
		if global.win_progress > 70:
			global.win_progress += 99 - global.win_progress
		else:
			global.win_progress +=30
	#if eventID == 14:
		#global.
	$"Sprite2D/Result Window/Description".text = chosenEvent[4]
	$"Sprite2D/Result Window".show()

func _on_option_2_pressed():
	$"Sprite2D/Choice Window".hide()
	#if eventID == 0:
		#global.
	#if eventID == 1:
		#global.
	#if eventID == 2:
		#global.
	#if eventID == 3:
		#global.beaconProgress += 1
	#if eventID == 4:
		#global.
	#if eventID == 5:
		#global.synthesizerBuilt = true
	#if eventID == 6:
		#global.
	#if eventID == 7:
		#global.
	#if eventID == 8:
		#global.
	#if eventID == 9:
		#global.
	#if eventID == 10:
		#global.synthesizerRunning = true
		#global.synthesizerLevel += 1
		#global.pollution += 0.1
	#if eventID == 11:
		#global.synthesizerLevel += 1
		#global.pollution += 0.1
	#if eventID == 12:
		#global.beaconProgress += 1
	#if eventID == 13:
		#global.beaconProgress += 1
	#if eventID == 14:
		#global.
	$"Sprite2D/Result Window".show()
	$"Sprite2D/Result Window/Description".text = chosenEvent[5]

func _on_ok_pressed():
	queue_free()

#func choice_made(var1: int, var2: bool, var3: bool, var4: int,):

