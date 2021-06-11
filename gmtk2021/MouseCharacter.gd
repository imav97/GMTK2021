extends KinematicBody2D

#movement variables
export var speed := 50
var velocity := Vector2.ZERO


func get_input():
	if Input.is_action_just_pressed("left_click"):
		
		if self.position.x > event.position.x:
			velocity.x = -1
		else:
			velocity.x = 1
		if self.position.y > event.position.y:
			velocity.y = -1
		else:
			velocity.y = 1
			
		velocity = velocity * speed



func _physics_process(delta):
	velocity = move_and_slide(velocity)
