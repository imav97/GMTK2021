extends KinematicBody2D

const ACCELERATION: int = 5
const DETECTION_RANGE: int = 100000
const ATTACK_RANGE: int = 400

export var damage: int = 10
export var player_node: NodePath

var player: KinematicBody2D
var speed := 30
var health := 100
var can_attack: bool = true

func _ready():
	player = get_node(player_node)


func _physics_process(delta: float) -> void:
	if !player == null:
		if self.global_position.distance_squared_to(player.global_position) < ATTACK_RANGE and can_attack:
			player.take_damage(self.damage)
			$AttackBuffer.start()
			$Grunt.play()
			can_attack = false
		
		if self.global_position.distance_squared_to(player.global_position) < DETECTION_RANGE:
			var player_direction = (player.global_position - self.global_position).normalized()
			if player.global_position.x < self.global_position.x:
				$Sprite.flip_h = true
			else:
				$Sprite.flip_h = false
			move_and_slide(speed * player_direction)
			
			if not $Grunt.playing:
				$Grunt.play()


func take_damage(damage: int) -> void:
	health -= damage
	$Hurt.play()
	if health <= 0:
		queue_free()



func hit_by_fire():
	$FireParticles.emitting = true


func hit_by_melee():
	$BloodParticles.emitting = true



func _on_AttackBuffer_timeout():
	can_attack = true
