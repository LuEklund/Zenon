extends Label3D

@export var health: Health

func _ready() -> void:
	health.damaged.connect(_on_damaged)
	health.healed.connect(_on_healed)
	health.died.connect(_on_death)

	redraw()

func _on_damaged(_amount: float) -> void:
	redraw()

func _on_healed(_amount: float) -> void:
	redraw()

func _on_death() -> void:
	text = "LOSER"

func redraw() -> void:
	text = "%d HP" % health.health
