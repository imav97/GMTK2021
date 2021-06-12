extends KinematicBody2D
signal took_damage(damage)

#movement variables
export var speed := 350
var velocity := Vector2.ZERO

# Attack variables
export var attack_cooldown_time := 400
export var attack_damage := 30
var next_attack_time := 0

#animation variables
onready var ani_player := $AnimationPlayer
var ani_playing := false



func get_input():
	velocity = Vector2.ZERO
	if Input.is_action_pressed('right'):
		velocity.x += 1
		$Sprite.flip_h = false
	if Input.is_action_pressed('left'):
		velocity.x -= 1
		$Sprite.flip_h = true
	if Input.is_action_pressed('down'):
		velocity.y += 1
	if Input.is_action_pressed('up'):
		velocity.y -= 1
	
	if Input.is_action_just_released("down") or Input.is_action_just_released("up") or Input.is_action_just_released("right") or Input.is_action_just_released("left"):
		play_idle()
	
	velocity = velocity.normalized() * speed

func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity)
	if velocity != Vector2.ZERO:
		$RayCast2D.cast_to = velocity.normalized() * 23
		ani_player.play("walk")


func _input(event):
	if event.is_action_pressed("simple_attack"):
		ani_player.play("attack")
		# Check if player can attack
		var now = OS.get_ticks_msec()
		if now >= next_attack_time:
			# Add cooldown time to current time
			next_attack_time = now + attack_cooldown_time
			var enemy = $RayCast2D.get_collider()
			if enemy != null:
				if enemy.name.find("BaseZombie") >= 0:
					enemy.melee_hit(attack_damage)
	
	if event.is_action_pressed("mana_attack"):
		print("range attack")


func play_idle():
	ani_player.play("idle")
	
func _take_damage(damage: int) -> void:
	emit_signal("took_damage", damage)
