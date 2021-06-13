extends Control



func _on_Start_pressed():
	$Fire.play()
	get_tree().change_scene("res://GeneralInstructions.tscn")


func _on_Credits_pressed():
	$Fire.play()
	get_tree().change_scene("res://Addons/godot-credits-master/GodotCredits.tscn")


func _on_Quit_pressed():
	$Fire.play()
	get_tree().quit()


func _on_Start_mouse_entered():
	$Sword.play()
	$MarginContainer/VBoxContainer/Buttons/HBoxContainer/AnimatedSaladdin.visible = true
	$MarginContainer/VBoxContainer/Buttons/HBoxContainer/AnimatedTemplar.visible = true


func _on_Start_mouse_exited():
	$MarginContainer/VBoxContainer/Buttons/HBoxContainer/AnimatedSaladdin.visible = false
	$MarginContainer/VBoxContainer/Buttons/HBoxContainer/AnimatedTemplar.visible = false


func _on_Credits_mouse_entered():
	$Sword.play()
	$MarginContainer/VBoxContainer/Buttons/HBoxContainer2/AnimatedSaladdin2.visible = true
	$MarginContainer/VBoxContainer/Buttons/HBoxContainer2/AnimatedTemplar2.visible = true


func _on_Credits_mouse_exited():
	$MarginContainer/VBoxContainer/Buttons/HBoxContainer2/AnimatedSaladdin2.visible = false
	$MarginContainer/VBoxContainer/Buttons/HBoxContainer2/AnimatedTemplar2.visible = false


func _on_Quit_mouse_entered():
	$Sword.play()
	$MarginContainer/VBoxContainer/Buttons/HBoxContainer3/AnimatedSaladdin3.visible = true
	$MarginContainer/VBoxContainer/Buttons/HBoxContainer3/AnimatedTemplar3.visible = true


func _on_Quit_mouse_exited():
	$MarginContainer/VBoxContainer/Buttons/HBoxContainer3/AnimatedSaladdin3.visible = false
	$MarginContainer/VBoxContainer/Buttons/HBoxContainer3/AnimatedTemplar3.visible = false


func _on_Start_focus_entered():
	$Fire.play()


func _on_Credits_focus_entered():
	$Fire.play()


func _on_Quit_focus_entered():
	$Fire.play()
