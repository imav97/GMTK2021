extends KinematicBody2D

#movement variables
export var speed :=  25
var velocity := Vector2.ZERO
var mouse_position := Vector2.ZERO


func get_movement():
	if self.position.x > mouse_position.x:
		velocity.x = -1
		print(self.position.x)
	else:
		velocity.x = 1
	
	if self.position.y > mouse_position.y:
		velocity.y = -1
	else:
		velocity.y = 1
			
		velocity = velocity * speed


func _input(event):
	if event is InputEventMouseButton:
		mouse_position = get_viewport().get_mouse_position()
		print(mouse_position)


func _physics_process(delta):
	get_movement()
	velocity = move_and_slide(velocity)
