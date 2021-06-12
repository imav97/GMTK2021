extends KinematicBody2D

const ACCELERATION: int = 5
const DETECTION_RANGE: int = 60000

onready var ani_player := $AnimationPlayer

var player: KinematicBody2D
var is_chasing: bool = false
var attack_timer := Timer
var velocity := Vector2.ZERO
var speed := 100

var health := 50


func _init():
	attack_timer.set_wait_time(1.0)


func _physics_process(delta: float) -> void:
	if !player == null:
		ani_player.play("walk")
		if self.position.distance_squared_to(player.position) < DETECTION_RANGE:
			var player_direction = (player.position - self.position).normalized()
			move_and_slide(speed * player_direction)
		
		
	if health <= 0:
		get_tree().queue_delete(self)


func melee_hit(damage):
	health -= damage
	print('melee hit registered')


func get_movement_direction():
	if self.position.x < player.position.x:
		velocity.x += 1
	else:
		velocity.x -= 1
		
	if self.position.y < player.position.y:
		velocity.y += 1
	else:
		velocity.y -= 1
	


func jump_attack():
	
	pass
