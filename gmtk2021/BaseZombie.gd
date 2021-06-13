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
			move_and_slide(speed * player_direction)


func take_damage(damage: int) -> void:
	health -= damage
	# TODO: Add VFX
	if health <= 0:
		queue_free()
	
