class_name Unit
extends Node3D

@onready var hit_ray: RayCast3D = $HitRay

@export var damage: float = 0.5
@export var speed: float = 3.8

var team: Team


func _physics_process(delta: float) -> void:
	var target := get_enemy_in_ray()

	if target != null:
		attack(target)
	else:
		position += transform.basis.x * speed * delta


func get_enemy_in_ray() -> Health:
	var friendly_colliders: Array[CollisionObject3D] = []

	while true:
		hit_ray.force_raycast_update()

		var collider := hit_ray.get_collider()

		if collider == null:
			break

		if collider is Health:
			var unit := collider.get_parent() as Unit

			if unit != null and team.is_enemy(unit.team):
				for friendly in friendly_colliders:
					hit_ray.remove_exception(friendly)

				return collider

			# Friendly unit — ignore it and check what's behind it.
			friendly_colliders.append(collider)
			hit_ray.add_exception(collider)
			continue

		# Wall/obstacle/etc.
		break

	# Nothing found.
	for friendly in friendly_colliders:
		hit_ray.remove_exception(friendly)

	return null


func attack(target_health: Health) -> void:
	target_health.health -= damage


func _on_death() -> void:
	queue_free()
