extends KinematicBody2D

#movement variables
export var speed := 350
var velocity := Vector2.ZERO

# Attack variables
export var attack_cooldown_time := 1000
export var attack_damage := 30
var next_attack_time := 0



func get_input():
	velocity = Vector2.ZERO
	if Input.is_action_pressed('right'):
		velocity.x += 1
	if Input.is_action_pressed('left'):
		velocity.x -= 1
	if Input.is_action_pressed('down'):
		velocity.y += 1
	if Input.is_action_pressed('up'):
		velocity.y -= 1
	
	velocity = velocity.normalized() * speed

func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity)
	if velocity != Vector2.ZERO:
		$RayCast2D.cast_to = velocity.normalized() * 10


func _input(event):
	if event.is_action_pressed("attack"):
	# Check if player can attack
		var now = OS.get_ticks_msec()
		if now >= next_attack_time:
			# Add cooldown time to current time
			next_attack_time = now + attack_cooldown_time
	
	if event.is_action_pressed("simple_attack"):
		print("melee attack")
	if event.is_action_pressed("simple_attack"):
		print("melee attack")
