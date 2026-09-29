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
	if spawn_point == null: return
	
	var instanced_scene = scene.instantiate()
	if instanced_scene is not Unit:
		var script: Variant = instanced_scene.get_script()

		push_error(
			"Failed to instantiate Unit from '%s': type=%s, script=%s"
			% [
				scene.resource_path,
				instanced_scene.get_class(),
				script.get_global_name() if script else "none",
			]
		)

		instanced_scene.queue_free()
		return
	var unit = instanced_scene as Unit
	if unit == null: 
		push_error("null instanced unit %s" % scene.resource_path)
		return

	unit.team = self
	add_child(unit)
	unit.global_position = spawn_point.global_position
	unit.scale.x = spawn_point.global_transform.basis.get_scale().x

func _on_death() -> void:
	print("team lost!!!")
