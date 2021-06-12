extends KinematicBody2D

const ACCELERATION: int = 1200

var direction: Vector2 = Vector2.ZERO
var offset: int = 200
var damage: int = 5


func init(direction: Vector2, initial_position: Vector2, damage: int = 5) -> void:
	self.direction = direction
	self.position = initial_position + offset * direction
	self.damage = damage


func _physics_process(delta: float) -> void:
	var collision = move_and_collide(direction * ACCELERATION * delta)
	if collision:
		# TODO: Do dmg, damage value comes from self.damage, which can be
		# passed in the init()
		print("collides")
		queue_free()
