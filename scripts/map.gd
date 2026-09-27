extends Node3D


@export var player: PackedScene = preload("res://scenes/player.tscn")
@export var size: float = 100.0 # radius

func _ready() -> void:
	var player_1 = player.instantiate() as Node3D
	var player_2 = player.instantiate() as Node3D
	
	add_child(player_1)
	add_child(player_2)
	
	player_1.position.x = -size
	player_2.position.x = size
	
	player_2.scale.x = -1
