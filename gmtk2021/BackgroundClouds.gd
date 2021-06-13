extends Node2D


export var speed:int
export var limit:int
export var right:bool = false

func _process(delta):
	if right:
		position.x += speed * delta
		if position.x >= limit:
			position.x = 0
	else:
		position.x += speed * delta
		if position.x <= limit:
			position.x = 0
