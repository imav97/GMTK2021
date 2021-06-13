extends KinematicBody2D

const ACCELERATION: int = 5
const DETECTION_RANGE: int = 100000
const ATTACK_RANGE: int = 1000

onready var ani_player := $AnimationPlayer

var player: KinematicBody2D
var is_chasing: bool = false
var timer
var velocity := Vector2.ZERO
var speed := 100
var health := 50
var attacking:=false



func _physics_process(delta: float) -> void:
	
	if !player == null:
		
		if self.position.distance_squared_to(player.global_position) < ATTACK_RANGE and attacking:
			player.take_damage(self.damage)
			$AttackBuffer.start()
			$Grunt.play()
		
		
		if self.position.distance_squared_to(player.position) < DETECTION_RANGE:
			var player_direction = (player.position - self.position).normalized()
			if player.position.x < self.position.x :
				$Sprite.flip_h = true
			else:
				$Sprite.flip_h = false
			move_and_slide(speed * player_direction)
		if !attacking:
			ani_player.play("walk")
		
	


func take_damage(damage: int) -> void:
	health -= damage
	
		
	if health <= 0:
		queue_free()



func jump_attack():
	timer = Timer.new() 
	timer.connect("timeout", self, "_on_timer_timeout")
	timer.one_shot = true
	add_child(timer)
	timer.start()


func _on_timer_timeout():
	attacking = false


func _on_Area2D_body_entered(body):
	if body.name == "Character":
		ani_player.play("attack")
		print("detected: ", body.name)
		attacking = true


func speed_up():
	speed = 300


func slow_down():
	speed = 75


func stop():
	speed = 0


func hit_by_fire():
	$FireParticles.emitting = true


func hit_by_melee():
	$BloodParticles.emitting = true
