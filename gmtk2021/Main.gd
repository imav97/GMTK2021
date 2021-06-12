extends Node

onready var camera_keyboard: Camera2D = $HBoxContainer/KeyboardChar/Viewport/Camera2D
onready var camera_mouse: Camera2D = $HBoxContainer/MouseChar/Viewport/Camera2D

onready var world_keyboard: Node2D = $HBoxContainer/KeyboardChar/Viewport/TEST_SCENE
onready var world_mouse: Node2D = $HBoxContainer/MouseChar/Viewport/Stage

func _ready() -> void:
	camera_keyboard.target = world_keyboard.get_node("KeyboardMovement")
	camera_mouse.target = world_mouse.get_node("MouseCharacter") 
	world_mouse.get_node("MouseCharacter").connect("took_damage", self, "_on_Character_damage")
	world_keyboard.get_node("KeyboardMovement").connect("took_damage", self, "_on_Character_damage")


func _character_damage(damage: int) -> void:
	# TODO: update shared health bar
	pass
