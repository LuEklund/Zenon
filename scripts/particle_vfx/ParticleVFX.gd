class_name ParticleVFX
extends Node3D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func play():
		animation_player.play("play")
		
func play_and_free():
	animation_player.play("play")
	await animation_player.animation_finished
	queue_free()
