extends TileMap
signal finished

func _ready() -> void:
	var enemies = get_tree().get_nodes_in_group("enemies")
	for enemy in enemies:
		enemy.player = $Character


func _physics_process(delta: float) -> void:
	var enemies = get_tree().get_nodes_in_group("enemies")
	if enemies.size() <= 0:
		emit_signal("finished")
