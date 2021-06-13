extends KinematicBody2D
signal took_damage(damage)

const PROJECTILE: PackedScene = preload("res://Projectile.tscn")
const ACCELERATION: int = 200


export var projectile_damage: int = 10
export var projectile_gauge: float = 100
export var projectile_depletion: int = 15
export var projectile_recovery: int = 5

export var melee_damage: int = 30
export var melee_range: int = 40
export var melee_gauge: float = 100
export var melee_depletion: int = 10
export var melee_recovery: int = 5

var initial_mouse_position := Vector2.ZERO
var final_mouse_position := Vector2.ZERO

var attack_direction: Vector2 = Vector2.ZERO

var projectile_depleted: bool = false
var melee_depleted: bool = false



func _input(event: InputEvent) -> void:
	if event.is_action_pressed("left_click"):
		initial_mouse_position = get_global_mouse_position()
	if event.is_action_released("left_click"):
		final_mouse_position = get_global_mouse_position()
		
		var delta_x: float = final_mouse_position.x - initial_mouse_position.x
		var delta_y: float = final_mouse_position.y - initial_mouse_position.y
		
		if abs(delta_x) < 5 and abs(delta_y) < 5:
			_fire_projectile(self.position.direction_to(final_mouse_position))
			return
		
		#choosing whether swipe was a horizontal or a vertical swipe
		if abs(delta_x) > abs(delta_y):
			#choosing whether swipe was to the right or to the left
			
			if final_mouse_position.x > self.position.x:
				$Sprite.flip_h = false
			else:
				$Sprite.flip_h = true
				
			_slash_attack(self.position.direction_to(final_mouse_position))
			

func _physics_process(delta: float):
	_movement_loop(delta)
	
	if projectile_depleted:
		projectile_gauge = projectile_gauge + projectile_recovery * delta
		if projectile_gauge >= 100:
			projectile_gauge = 100
			projectile_depleted = false
		
		$Control/VBoxContainer/HBoxContainer2/FireGauge.value = projectile_gauge
	
	if melee_depleted:
		melee_gauge = melee_gauge + melee_recovery * delta
		if melee_gauge >= 100:
			melee_gauge = 100
			melee_depleted = false
		
		$Control/VBoxContainer/HBoxContainer/MeleeGauge.value = melee_gauge


func _movement_loop(delta: float):
	var direction: Vector2 = Vector2.ZERO
	
	if Input.is_mouse_button_pressed(BUTTON_RIGHT):
		var mouse_position: Vector2 = get_global_mouse_position()
		if mouse_position.x > self.position.x:
			$Sprite.flip_h = false
		else:
			$Sprite.flip_h = true
		if self.position.distance_squared_to(mouse_position) > 100:
			direction = self.position.direction_to(mouse_position)
	
	var speed: Vector2 = direction * ACCELERATION
	
	if speed.length_squared() > 0:
		$AnimationPlayer.play("walk")
	else:
		$AnimationPlayer.stop()
	
	move_and_slide(speed, Vector2.UP)
	

func _fire_projectile(direction: Vector2):
	if projectile_gauge > 0 and not projectile_depleted:
		var projectile: KinematicBody2D = PROJECTILE.instance()
		projectile.init(direction, self.global_position, projectile_damage)
		get_parent().add_child(projectile)
		
		$Fire.play()
		projectile_gauge = projectile_gauge - projectile_depletion
		$Control/VBoxContainer/HBoxContainer2/FireGauge.value = projectile_gauge
		
		if projectile_gauge <= 0:
			projectile_depleted = true
	else:
		# TODO: Animation no energy for projectile
		pass


func _slash_attack(direction: Vector2):
	if melee_gauge > 0 and not melee_depleted:
		$RayCast2D.cast_to = direction * melee_range
		$Sword.play()
		
		if $RayCast2D.is_colliding():
			var collider: Object = $RayCast2D.get_collider()
			if collider.has_method("take_damage"):
				collider.take_damage(melee_damage)
			
			melee_gauge = melee_gauge - melee_depletion
			$Control/VBoxContainer/HBoxContainer/MeleeGauge.value = melee_gauge
			
			
			if melee_gauge <= 0:
				melee_depleted = true
	else:
		# TODO: Animation no energy for projectile
		pass

func _set_melee_gauge(value: float) -> float:

	melee_gauge = value
	return self.melee_gauge
	


func take_damage(damage: int) -> void:
	$Hurt.play()
	emit_signal("took_damage", damage)
