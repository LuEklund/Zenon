class_name Player
extends Node

signal spawn_unit(scene: PackedScene)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("spawn_miner"):
		spawn_unit.emit(Unit.MINER)
