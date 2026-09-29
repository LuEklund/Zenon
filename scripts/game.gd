extends Node3D

const BASE = preload("res://scenes/units/base.tscn")

@export var size: float = 50.0

var team_player: Team
var team_ai: Team

func _ready() -> void:
	var player = HumanPlayer.new() as Player
	var ai_player = AiPlayer.new() as Player

	var player_base = BASE.instantiate() as Unit
	var ai_base = BASE.instantiate() as Unit

	player_base.position.x = -size
	ai_base.position.x = size
	ai_base.scale.x = -1.0

	team_player = Team.new(
		player,
		player_base.get_node("Health"),
		player_base.get_node("SpawnPoint"),
	)

	team_ai = Team.new(
		ai_player,
		ai_base.get_node("Health"),
		ai_base.get_node("SpawnPoint"),
	)

	player_base.team = team_player
	ai_base.team = team_ai

	add_child(player_base)
	add_child(ai_base)

	add_child(player)
	add_child(ai_player)
	add_child(team_player)
	add_child(team_ai)
