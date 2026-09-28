extends Area3D

@onready var particles: GPUParticles3D = $GPUParticles3D

func _on_body_entered(body: Node3D) -> void:
	particles.restart()
	particles.emitting = true
