extends Node3D

@export var player: PackedScene = preload("res://scenes/player.tscn")
@export var size: float = 100.0

func _ready() -> void:
	var player_1 := player.instantiate() as Player
	var player_2 := player.instantiate() as Player

	add_child(player_1)
	add_child(player_2)

	player_1.spawn(0)
	player_2.spawn(1)

	player_1.position.x = -size
	player_2.position.x = size

	player_2.scale.x = -1
