extends RigidBody3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var movement := Vector2(
		Input.get_axis("move_left", "move_right"),
		Input.get_axis("move_backwards", "move_forward")
	)
	position.x += movement.x * delta
	position.z += movement.y * delta
	
	move_and_slide()
