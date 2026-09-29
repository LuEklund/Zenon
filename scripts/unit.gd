class_name Unit
extends Node3D

@onready var hit_ray: RayCast3D = $HitRay

## Damage dealt per physics frame. 60 physics frames = 1 second.
@export var damage: float = 0.5
@export var speed: float = 3.8

var team: Team

func _physics_process(delta: float) -> void:
	var target := hit_ray.get_collider()

	if target is Health:
		var unit := target.get_parent() as Unit

		if unit == null or not team.is_enemy(unit.team):
			position += transform.basis.x * speed * delta
			return

		attack(target)
		return

	position += transform.basis.x * speed * delta

func attack(target_health: Health) -> void:
	target_health.health -= damage

func _on_death() -> void:
	queue_free()
