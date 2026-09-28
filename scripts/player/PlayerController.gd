class_name PlayerController
extends Node

@export var unit_scenes: Array[UnitScene] = [
	UnitScene.new(
		Unit.Kind.MINER,
		preload("res://scenes/units/miner.tscn"),
	),
	UnitScene.new(
		Unit.Kind.GOBLIN_MAN,
		preload("res://scenes/units/goblin_man.tscn"),
	),
]

@warning_ignore("unused_signal")
signal spawn_unit(kind: Unit.Kind)

func get_scene(kind: Unit.Kind) -> PackedScene:
	for unit_scene in unit_scenes:
		if unit_scene.kind != kind: continue
		assert(unit_scene.scene != null, "No scene assigned for unit kind: %s" % kind)
		return unit_scene.scene

	assert(false, "No scene registered for unit kind: %s" % kind)
	return null
