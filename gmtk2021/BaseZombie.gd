extends KinematicBody2D

const ACCELERATION: int = 5
const DETECTION_RANGE: int = 60000

var target: KinematicBody2D
var is_chasing: bool = false

func init(character: KinematicBody2D) -> void:
	target = character

func _physics_process(delta: float) -> void:
	if self.position.distance_squared_to(target.position) < DETECTION_RANGE:
		# TODO: Move towards target character
		pass
