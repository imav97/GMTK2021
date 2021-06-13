extends TileMap
signal finished


func _physics_process(delta: float) -> void:
	var enemies = get_tree().get_nodes_in_group("enemies")
	if enemies.size() <= 0:
		emit_signal("finished")
