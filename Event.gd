extends CenterContainer
var eventID
var eventDescription
var eventChoice1
var eventChoice2
var synthesizerBuilt = false
var synthesizerRunning = false
var beaconProgress = 0
var consequences #this one is an array
signal event_finished
var possibleEvents

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func update_text(description: String, choice1: String, choice2: String,):
	$CanvasLayer/Event/EventBackground/RichTextLabel.text = description
	$EventBackground/HFlowContainer/CenterContainer/TextureButton1/ChoiceText1.text = choice1
	$EventBackground/HFlowContainer/CenterContainer2/TextureButton2/ChoiceText2.text = choice2

func _on_texture_button_1_pressed():
	$".".hide()

func _on_texture_button_2_pressed():
	$".".hide()

func _on_end_turn_pressed():
	var possibleEvents = [4, 6, 7, 8]
	# Lubricant Synthesis Events
	if synthesizerBuilt == true:
		if synthesizerRunning == true:
			possibleEvents.append(11)
		else:
			possibleEvents.append(10)
	else: 
		possibleEvents.append(5)
	# Beacon Events
	if beaconProgress > 0:
		if beaconProgress >1:
			possibleEvents.append(13)
		else:
			possibleEvents.append(12)
	else:
		possibleEvents.append(3)
	

#func choice_made(var1: float, var2: float, var3: float):
	

func eventSelector(events: Array):
	var random_choice = events.pick_random()
	return random_choice
