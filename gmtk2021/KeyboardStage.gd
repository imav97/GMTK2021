extends Node2D

onready var player:= $Saladin


func _ready():
#	spawn_zombie()
	spawn_crawler_zombie()

func spawn_zombie():
	var zombie = load("res://BaseZombie.tscn")
	var zombie_instance = zombie.instance()
	zombie_instance.position.x = 150
	zombie_instance.position.y = 150
	add_child(zombie_instance)
	zombie_instance.player = player


func spawn_crawler_zombie():
	var zombie = load("res://CrawlerZombie.tscn")
	var zombie_instance = zombie.instance()
	zombie_instance.position.x = 0
	zombie_instance.position.y = 0
	add_child(zombie_instance)
	zombie_instance.player = player
