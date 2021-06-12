extends Node2D

const ENEMIES: PackedScene = preload("res://BaseZombie.tscn")

onready var enemies: Node = $Enemies


func _process(delta: float) -> void:
	if enemies.get_child_count() <= 0:
		_spawn_wave()


func _spawn_wave() -> void:
	for i in range(rand_range(3, 6)):
		var enemy: KinematicBody2D = ENEMIES.instance()
		enemy.init($MouseCharacter)
		enemies.add_child(enemy)
