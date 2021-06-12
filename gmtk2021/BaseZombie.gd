extends KinematicBody2D

const ACCELERATION: int = 5
const DETECTION_RANGE: int = 60000

var player: KinematicBody2D
var is_chasing: bool = false

var velocity := Vector2.ZERO
var speed := 100

var health := 100



#func init(character: KinematicBody2D) -> void:
#	player = character

func _physics_process(delta: float) -> void:
	if !player == null:
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
