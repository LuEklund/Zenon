extends Node3D

@onready var camera: Camera3D = $Camera3D

@export var default_speed: float = 8.0
@export var fast_speed: float = 14.0

@export var zoom_speed: float = 0.15
@export var zoom_smoothness: float = 10.0
@export var zoom_finish_margin: float = 0.1

@export var movement_smoothness: float = 12.0

@export var min_zoom: float = 6.0
@export var max_zoom: float = 180.0

var target_zoom: float
var current_speed: float = 0.0

func _ready() -> void:
	target_zoom = camera.size
	current_speed = default_speed

func _physics_process(delta: float) -> void:
	var base_speed := (
		fast_speed
		if Input.is_action_pressed("move_fast")
		else default_speed
	)

	var zoom_factor := sqrt(camera.size / min_zoom)
	var target_speed := base_speed * zoom_factor

	current_speed = lerpf(
		current_speed,
		target_speed,
		1.0 - exp(-movement_smoothness * delta)
	)

	var movement := Input.get_axis(
		"move_left",
		"move_right"
	)

	position.x = clampf(
		position.x + movement * current_speed * delta,
		-100.0,
		100.0
	)

	var zoom_changed := not is_equal_approx(
		camera.size,
		target_zoom
	)

	if zoom_changed:
		var mouse := get_viewport().get_mouse_position()

		var before := get_mouse_world_position(mouse)

		camera.size = lerpf(
			camera.size,
			target_zoom,
			1.0 - exp(-zoom_smoothness * delta)
		)

		if absf(camera.size - target_zoom) <= zoom_finish_margin:
			camera.size = target_zoom

		camera.position.y = camera.size / 2.0 - 1.0

		var after := get_mouse_world_position(mouse)

		var displacement := before - after

		position += Vector3(
			displacement.x,
			0.0,
			displacement.z
		)
	else:
		camera.position.y = camera.size / 2.0 - 1.0


func _unhandled_input(event: InputEvent) -> void:
	if event is not InputEventMouseButton:
		return

	if (
		event.button_index != MOUSE_BUTTON_WHEEL_UP
		and event.button_index != MOUSE_BUTTON_WHEEL_DOWN
	):
		return

	if event.button_index == MOUSE_BUTTON_WHEEL_UP:
		target_zoom = clampf(
			target_zoom * (1.0 - zoom_speed),
			min_zoom,
			max_zoom
		)

	elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
		target_zoom = clampf(
			target_zoom * (1.0 + zoom_speed),
			min_zoom,
			max_zoom
		)


func get_mouse_world_position(mouse: Vector2) -> Vector3:
	var origin := camera.project_ray_origin(mouse)
	var direction := camera.project_ray_normal(mouse)

	if is_zero_approx(direction.y): return origin

	var distance := -origin.y / direction.y

	return origin + direction * distance
