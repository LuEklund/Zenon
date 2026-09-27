extends Unit

func _ready() -> void:
	died.connect(_on_died)

func _on_died() -> void:
	queue_free()
