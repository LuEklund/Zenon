class_name AiPlayer
extends Player

var timer := Timer.new()

func _ready() -> void:
	timer.wait_time = 1.0
	timer.timeout.connect(_on_timer_timeout)
	add_child(timer)
	timer.start()

func _on_timer_timeout() -> void:
	spawn_unit.emit(archer)
