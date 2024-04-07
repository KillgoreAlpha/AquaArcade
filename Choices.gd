extends CenterContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_choice_1_pressed():
	
	$".".hide()
	$"../Event".show()


func _on_choice_2_pressed():

	$".".hide()
	$"../Event".show()

func _on_choice_3_pressed():

	$".".hide()
	$"../Event".show()
