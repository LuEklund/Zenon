class_name Health
extends Node

@export var value: float = 100.0

func damage(amount: float) -> void:
	value = maxf(value - amount, 0.0)

func is_dead() -> bool:
	return value <= 0.0
