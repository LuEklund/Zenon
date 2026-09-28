extends Unit

@export var richness: float = 40.0 / 60

func _ready() -> void:
	damaged.connect(_damaged)
	collision_layer = team_collision_layer()

func _damaged(attacker: Unit, _amount: float) -> void:
	attacker.player.gold += richness
	health = 1000
