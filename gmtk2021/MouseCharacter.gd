extends KinematicBody2D

var acceleration := 800

var initial_mouse_position := Vector2.ZERO
var final_mouse_position := Vector2.ZERO

var attack_direction: Vector2 = Vector2.ZERO



func _unhandled_input(event):
	if event.is_action_pressed("left_click"):
		initial_mouse_position = event.position
	if event.is_action_released("left_click"):
		final_mouse_position = event.position
		
		var delta_x: float = final_mouse_position.x - initial_mouse_position.x
		var delta_y: float = final_mouse_position.y - initial_mouse_position.y
		
		if abs(delta_x) < 5 and abs(delta_y) < 5:
			_fire_projectile(self.position.direction_to(final_mouse_position))
			return
		
		#choosing whether swipe was a horizontal or a vertical swipe
		if abs(delta_x) > abs(delta_y):
			#choosing whether swipe was to the right or to the left
			if delta_x > 0 :
				attack_direction = Vector2.RIGHT
			else:
				attack_direction = Vector2.LEFT
		

func _physics_process(delta: float):
	_movement_loop(delta)


func _movement_loop(delta: float):
	var direction: Vector2 = Vector2.ZERO
	
	if Input.is_mouse_button_pressed(BUTTON_RIGHT):
		var mouse_position: Vector2 = get_viewport().get_mouse_position()
		if mouse_position.x > self.position.x:
			$Sprite.flip_h = false
		else:
			$Sprite.flip_h = true
		if self.position.distance_squared_to(mouse_position) > 100:
			direction = self.position.direction_to(mouse_position)
	
	var speed: Vector2 = direction * acceleration
	
	if speed.length_squared() > 0:
		$AnimationPlayer.play("walk")
	else:
		$AnimationPlayer.stop()
	
	move_and_slide(speed, Vector2.UP)
	

func _fire_projectile(direction: Vector2):
	# TODO: Add to root a projectile moving towards the given direction
	pass


func _slash_attack():
	# TODO: Do damage in the melee range of the attack_direction
	pass





