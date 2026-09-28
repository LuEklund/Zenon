extends PlayerController


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("spawn_miner"): spawn_unit.emit(Unit.Kind.MINER)
	if event.is_action_pressed("test"): spawn_unit.emit(Unit.Kind.GOBLIN_MAN)

func _on_spawn_miner_pressed() -> void:
	spawn_unit.emit(Unit.Kind.MINER)

func _on_spawn_goblin_pressed() -> void:
	spawn_unit.emit(Unit.Kind.GOBLIN_MAN)
