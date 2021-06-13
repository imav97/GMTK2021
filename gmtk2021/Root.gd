extends Control



func _on_Start_pressed():
	get_tree().change_scene("res://GeneralInstructions.tscn")


func _on_Credits_pressed():
	get_tree().change_scene("res://Addons/godot-credits-master/GodotCredits.tscn")


func _on_Quit_pressed():
	get_tree().quit()
