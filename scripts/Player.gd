class_name Player
extends Node3D

@onready var statue: Unit = $Statue
@onready var spawner: Node3D = $Spawner


@export var units: Array[PackedScene] = [
	preload("res://scenes/units/goblin_man.tscn"),
]

@export var team: int

func spawn(new_team: int) -> void:
	team = new_team
	statue.team = new_team

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("test"): spawn_unit(0)

func spawn_unit(index: int) -> void:
	var unit = units[index].instantiate()
	unit.team = team

	spawner.add_child(unit);
