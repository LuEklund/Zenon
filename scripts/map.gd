extends Node3D

@export var size: float = 100.0

@export var hud_scene: PackedScene = preload("res://scenes/ui/hud.tscn")
@export var ai_scene: PackedScene = preload("res://scenes/ai_controller.tscn")

@export var player: PackedScene = preload("res://scenes/player.tscn")
@export var gold_deposit: PackedScene = preload("res://scenes/units/gold_deposit.tscn")


func _ready() -> void:
	var hud := hud_scene.instantiate() as PlayerController
	var ai := ai_scene.instantiate() as PlayerController
	add_child(hud)
	add_child(ai)
	
	var player_1 := player.instantiate() as Player
	var player_2 := player.instantiate() as Player
	var gold_deposit_middle := gold_deposit.instantiate() as Unit

	add_child(player_1)
	add_child(player_2)

	player_1.spawn(hud, 0)
	player_2.spawn(ai, 1)

	player_1.position.x = -size
	player_2.position.x = size

	player_2.scale.x = -1
	
	
	add_child(gold_deposit_middle)
	gold_deposit_middle.team = 3
	gold_deposit_middle.position = global_position
