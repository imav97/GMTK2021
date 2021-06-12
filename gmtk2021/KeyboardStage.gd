extends Node2D

onready var player:= $Saladdin


func _ready():
	spawn_zombie()

func spawn_zombie():
	var zombie = load("res://BaseZombie.tscn")
	var zombie_instance = zombie.instance()
	zombie_instance.position.x = 0
	zombie_instance.position.y = 0
	add_child(zombie_instance)
	zombie_instance.player = player
