extends KinematicBody2D

const ACCELERATION: int = 5
const DETECTION_RANGE: int = 100000
const ATTACK_RANGE: int = 30000

export var damage: int = 10

var player: KinematicBody2D
var speed := 100
var health := 100

func _ready():
	player = get_parent().get_node("Character")

func _physics_process(delta: float) -> void:
	if !player == null:
		if self.position.distance_squared_to(player.global_position) < ATTACK_RANGE:
			player.take_damage(self.damage)
		
		if self.position.distance_squared_to(player.position) < DETECTION_RANGE:
			var player_direction = (player.global_position - self.global_position).normalized()
			if player.position.x < self.position.x:
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
	
