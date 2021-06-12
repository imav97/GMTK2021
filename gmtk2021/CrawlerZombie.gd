extends KinematicBody2D

const ACCELERATION: int = 5
const DETECTION_RANGE: int = 60000

onready var ani_player := $AnimationPlayer

var player: KinematicBody2D
var is_chasing: bool = false
var timer
var velocity := Vector2.ZERO
var speed := 100
var health := 50
var attacking:=false



func _physics_process(delta: float) -> void:
	if timer:
		if timer.get_time_left() < 0.75:
			speed = 300
			print("executing timer")
		

	if !player == null and !attacking:
		ani_player.play("walk")
		if self.position.distance_squared_to(player.position) < DETECTION_RANGE:
			var player_direction = (player.position - self.position).normalized()
			move_and_slide(speed * player_direction)
		
		
	if health <= 0:
		get_tree().queue_delete(self)


func take_damage(damage: int) -> void:
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
	print("attacking")
	attacking = true
	speed = 0
	timer = Timer.new() 
	timer.connect("timeout", self, "_on_timer_timeout")
	timer.one_shot = true
	timer.start()


func _on_timer_timeout():
	speed = 75
	print('timer timedout')
	attacking = false


func _on_Area2D_body_entered(body):
	if body.name == "Saladin" or body.name == "Templar":
		ani_player.play("attack")
		print("detected: ", body.name)
