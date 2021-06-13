extends Node

export(NodePath) var world_keyboard_node: NodePath
export(NodePath) var world_mouse_node: NodePath
export(String, FILE, "*.tscn") var next_main: String

var world_keyboard
var world_mouse

var health: int = 100
var waves_cleared: int = 0

onready var camera_keyboard: Camera2D = $Viewports/KeyboardChar/Viewport/Camera2D
onready var camera_mouse: Camera2D = $Viewports/MouseChar/Viewport/Camera2D


func _ready() -> void:
	world_keyboard = get_node(world_keyboard_node)
	world_mouse = get_node(world_mouse_node)
	world_keyboard.connect("finished", self, "_on_Wave_Finished")
	camera_keyboard.target = world_keyboard.get_node("Character")
	camera_mouse.target = world_mouse.get_node("Character") 
	world_mouse.get_node("Character").connect("took_damage", self, "_on_Character_damage")
	world_keyboard.get_node("Character").connect("took_damage", self, "_on_Character_damage")
	
	$CanvasLayer/Control/CenterContainer/TextureProgress.value = health	


func _on_Wave_Finished() -> void:
	waves_cleared += 1
	if waves_cleared >= 2:
		get_tree().change_scene(next_main)


func _on_Character_damage(damage: int) -> void:
	health -= damage
	$CanvasLayer/Control/CenterContainer/TextureProgress.value = health
	
	if health <= 0:
		get_tree().change_scene("res://GameOver.tscn")
