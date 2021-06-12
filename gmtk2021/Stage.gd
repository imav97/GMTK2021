extends Node2D

const ENEMIES: PackedScene = preload("res://BaseZombie.tscn")

onready var enemies: Node = $Enemies


func _ready():
	var enemies = get_tree().get_nodes_in_group("enemies")
	for enemy in enemies:
		enemy.player = $MouseCharacter


func _on_Timer_timeout(spawn: int):
	var enemy: KinematicBody2D = ENEMIES.instance()
	enemy.player = $MouseCharacter
	match spawn:
		0:
			enemy.position = $Spawn1.position
		1:
			enemy.position = $Spawn2.position
		2:
			enemy.position = $Spawn3.position
		3:
			enemy.position = $Spawn4.position
		
	get_tree().root.add_child(enemy)
