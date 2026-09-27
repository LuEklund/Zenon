class_name Health
extends Node

@export var target: Node

@export var value: float = 100.0

func _ready() -> void:
	if target == null: target = get_parent()

func damage(amount: float) -> void:
	value = maxf(value - amount, 0.0)
	
	if is_dead(): kill()


func is_dead() -> bool:
	return value <= 0.0

func kill() -> void:
	target.queue_free()
