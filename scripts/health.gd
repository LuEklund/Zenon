class_name Health
extends Area3D

signal healed(amount: float)
signal damaged(amount: float)
signal died

@export var max_health: float = 100.0

var health: float = max_health:
	get:
		return health
	set(value):
		var previous := health
		health = clampf(value, 0.0, max_health)

		if health > previous:
			healed.emit(health - previous)
		elif health < previous:
			damaged.emit(previous - health)

		if previous > 0.0 and health <= 0.0:
			died.emit()

func _ready() -> void:
	health = max_health
