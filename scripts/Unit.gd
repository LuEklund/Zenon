class_name Unit
extends StaticBody3D

signal damaged(amount: float)
signal died

@export var team: int = 0
@export var health: float = 100.0

func damage(amount: float) -> void:
	if health <= 0.0: return

	health = maxf(health - amount, 0.0)
	damaged.emit(amount)

	if health <= 0.0: died.emit()
