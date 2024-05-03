extends Node2D

func _ready():
	pass

func _on_option_1_pressed():
	$"Sprite2D/Choice Window".hide()
	$"Sprite2D/Result Window".show()

func _on_option_2_pressed():
	$"Sprite2D/Choice Window".hide()
	$"Sprite2D/Result Window".show()

func _on_ok_pressed():
	queue_free()
