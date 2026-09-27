extends Node3D

@export var units: Array[PackedScene] = [
	preload("res://scenes/units/goblin_man.tscn"),
]

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("test"):
		var unit := units[0].instantiate() as Unit
		add_child(unit)

		unit.global_position = global_position
