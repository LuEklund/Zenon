class_name Team
extends Node

const START_GOLD = 900

var gold: int = START_GOLD

var spawn_point: Node3D

func _init(player: Player, health: Health, new_spawn_point: Node3D) -> void:
	player.spawn_unit.connect(_on_spawn_unit)
	health.died.connect(_on_death)
	spawn_point = new_spawn_point

func is_enemy(other: Team) -> bool:
	return other != self

func _on_spawn_unit(scene: PackedScene) -> void:
	var unit = scene.instantiate() as Unit
	unit.team = self
	add_child(unit)
	unit.global_position = spawn_point.global_position
	unit.scale.x = spawn_point.global_transform.basis.get_scale().x

func _on_death() -> void:
	print("team lost!!!")
