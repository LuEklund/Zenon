extends PlayerController

func _on_spawn_timer_timeout() -> void:
	spawn_unit.emit(Unit.Kind.MINER)
