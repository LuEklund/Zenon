extends Node3D

@onready var camera: Camera3D = $Camera3D

@export var default_speed: float = 0.6
@export var fast_speed: float = 0.8
@export var zoom_speed: float = 2.0
@export var min_zoom: float = 6.0
@export var max_zoom: float = 180.0

func _physics_process(delta: float) -> void:
	var speed: float = fast_speed if Input.is_action_pressed("move_fast") else default_speed

	var movement := Input.get_axis("move_left", "move_right")
	position.x = clampf(
		position.x + movement * speed,
		-100.0,
		100.0
	)

func _unhandled_input(event: InputEvent) -> void:
	if event is not InputEventMouseButton:
		return

	if event.button_index == MOUSE_BUTTON_WHEEL_UP:
		camera.size = clampf(
			camera.size - zoom_speed,
			min_zoom,
			max_zoom
		)

	elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
		camera.size = clampf(
			camera.size + zoom_speed,
			min_zoom,
			max_zoom
		)

	camera.position.y = camera.size / 2.0 - 1.0
