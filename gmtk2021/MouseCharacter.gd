extends KinematicBody2D

var max_speed := 400
var speed := 0 
var acceleration := 1200
var move_direction
var moving := false
var destination := Vector2.ZERO
var movement := Vector2.ZERO

var initial_mouse_position := Vector2.ZERO
var final_mouse_position := Vector2.ZERO



func _unhandled_input(event):
	if event.is_action_pressed("right_click"):
		moving=true
		destination = get_global_mouse_position()
	
	if event.is_action_pressed("left_click"):
		initial_mouse_position = event.position
	if event.is_action_released("left_click"):
		final_mouse_position = event.position
		
		#choosing whether it was a horizontal or a vertical swipe
		if abs(final_mouse_position.x - initial_mouse_position.x) > abs(final_mouse_position.y - initial_mouse_position.y):
			print("swipe was horizontal ")
		else:
			print("swipe was vertical ")

func _physics_process(delta):
	movement_loop(delta)


func movement_loop(delta):
	if !moving:
		speed = 0
	else:
		speed += acceleration * delta
		if speed > max_speed:
			speed = max_speed
	movement = position.direction_to(destination) * speed
	if position.distance_to(destination) > 5:
		movement = move_and_slide(movement)
	else:
		moving = false





