extends KinematicBody2D
signal took_damage(damage)

const PROJECTILE: PackedScene = preload("res://Projectile.tscn")

onready var melee_progress := $Control/VBoxContainer/VBoxContainer/HBoxContainer/MeleeProgress
onready var mana_progress := $Control/VBoxContainer/VBoxContainer/HBoxContainer2/ManaProgress

#movement variables
export var speed := 350
var velocity := Vector2.ZERO

# Attack variables
export var attack_cooldown_time := 500
export var attack_damage := 30
var next_attack_time := 0

#animation variables
onready var ani_player := $AnimationPlayer
var ani_playing := false

var melee_timer : Timer
var mana_timer : Timer

var melee_ready:=true
var mana_ready:=true


func _ready():
	melee_timer = Timer.new()
	melee_timer.set_wait_time(0.5)
	melee_timer.set_one_shot(true)
	melee_timer.set_autostart(false)
#	melee_timer.connect("timeout", self, "_on_melee_timeout")
	add_child(melee_timer)
	
	mana_timer = Timer.new()
	mana_timer.set_wait_time(0.75)
	mana_timer.set_one_shot(true)
	mana_timer.set_autostart(false)
#	mana_timer.connect("timeout", self, "_on_mana_timeout")
	add_child(mana_timer)



func get_input():
	velocity = Vector2.ZERO
	if Input.is_action_pressed('right') and !ani_playing:
		velocity.x += 1
		$Sprite.flip_h = false
	if Input.is_action_pressed('left') and !ani_playing:
		velocity.x -= 1
		$Sprite.flip_h = true
	if Input.is_action_pressed('down') and !ani_playing:
		velocity.y += 1
	if Input.is_action_pressed('up')and !ani_playing:
		velocity.y -= 1
	
	if !Input.is_action_pressed("down") and !Input.is_action_pressed("up") and !Input.is_action_pressed("right") and !Input.is_action_pressed("left") and !ani_playing:
		play_idle()
	
	velocity = velocity.normalized() * speed


func _physics_process(delta):
	melee_progress.value = melee_timer.time_left
	mana_progress.value = mana_timer.time_left
	get_input()
	velocity = move_and_slide(velocity)
	if velocity != Vector2.ZERO:
		$RayCast2D.cast_to = velocity.normalized() * 23
		ani_player.play("walk")


func _input(event):
	if event.is_action_pressed("simple_attack") and melee_timer.is_stopped():
		melee_timer.start()
		ani_player.play("attack")
		ani_playing = true
		melee_ready = false
		$Sword.play()
		var enemy = $RayCast2D.get_collider()
		if enemy != null:
			if enemy.has_method("take_damage"):
				enemy.take_damage(attack_damage)
	
	if event.is_action_pressed("mana_attack") and mana_timer.is_stopped():
		mana_timer.start()
		ani_playing = true
		ani_player.play("cast")
		var projectile: KinematicBody2D = PROJECTILE.instance()
		var direction = $RayCast2D.cast_to.normalized()
		projectile.init(direction, self.position, attack_damage)
		get_parent().add_child(projectile)
		$Fire.play()


func play_idle():
	ani_player.play("idle")


func _take_damage(damage: int) -> void:
	$Hurt.play()
	emit_signal("took_damage", damage)


func finished_animation():
	ani_playing = false
	

func take_damage(damage: int) -> void:
	emit_signal("took_damage", damage)


func _on_AnimationPlayer_animation_finished(anim_name):
	ani_playing = false


#func _on_melee_timeout():
#	print("timer timedout")
#	melee_ready = true
#
