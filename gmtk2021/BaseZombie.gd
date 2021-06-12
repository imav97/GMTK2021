extends KinematicBody2D

const ACCELERATION: int = 1200

var target: KinematicBody2D
var is_chasing: bool = false

func init(character: KinematicBody2D) -> void:
	target = character

func _physics_process(delta: float) -> void:
	if is_chasing:
		var direction: Vector2 = self.position.direction_to(target.position)
		var speed: Vector2 = direction * ACCELERATION
		move_and_slide(speed, Vector2.UP)


func _on_PlayerDetection_body_entered(body: PhysicsBody2D) -> void:
	is_chasing = true


func _on_PlayerDetection_body_exited(body: PhysicsBody2D) -> void:
	is_chasing = false
