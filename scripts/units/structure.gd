extends Unit

@export var can_die: bool = true

func _ready() -> void:
	died.connect(_on_died)
	collision_layer = team_collision_layer()

func _on_died() -> void:
	if can_die: queue_free()
