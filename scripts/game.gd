extends Node3D

const BASE = preload("res://scenes/base.tscn")

@export var size: float = 50.0

var team_player: Team
var team_ai: Team

func _ready() -> void:
	var player_base = BASE.instantiate() as Node3D
	var ai_base = BASE.instantiate() as Node3D
	add_child(player_base)
	add_child(ai_base)
	ai_base.scale.x = -1.0
	
	player_base.global_position.x = -size
	ai_base.global_position.x = size
	
	var player = Player.new()
	var ai_player = Player.new()
	
	team_player = Team.new(player, player_base.get_node("Health"), player_base.get_node("SpawnPoint"))
	team_ai = Team.new(ai_player, ai_base.get_node("Health"), ai_base.get_node("SpawnPoint"))
	
	add_child(player)
	add_child(ai_player)
	add_child(team_player)
	add_child(team_ai)
