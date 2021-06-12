extends Node2D

onready var zombie := $BaseZombie
onready var player := $KeyboardMovement

# Called when the node enters the scene tree for the first time.
func _ready():
	zombie.player = player

