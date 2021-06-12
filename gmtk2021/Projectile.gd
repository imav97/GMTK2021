extends KinematicBody2D

const ACCELERATION: int = 1200

var direction: Vector2 = Vector2.ZERO


func init(direction: Vector2) -> void:
	self.direction = direction


func _physics_process(delta: float) -> void:
	var collision = move_and_collide(direction * ACCELERATION)
	if collision:
		# TODO: Do dmg
		queue_free()
