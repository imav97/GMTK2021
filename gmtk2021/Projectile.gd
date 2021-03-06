extends KinematicBody2D

const ACCELERATION: int = 800

var direction: Vector2 = Vector2.ZERO
var offset: int = 100
var damage: int = 5


func init(direction: Vector2, initial_position: Vector2, damage: int = 5) -> void:
	self.direction = direction
	self.position = initial_position + offset * direction
	self.damage = damage


func _physics_process(delta: float) -> void:
	var collision = move_and_collide(direction * ACCELERATION * delta)
	if collision:
		
		if collision.collider.has_method("take_damage") and collision.collider.collision_layer == 1:
			collision.collider.take_damage(self.damage)
		
		queue_free()

