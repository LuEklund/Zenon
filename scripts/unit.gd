class_name Unit
extends CharacterBody3D

enum Team {
	SELF,
	ENEMY,
}

enum State {
	IDLE,
	ACTIVE,
	DEAD,
}

@onready var health: Health  = $Health
@onready var damage_ray: RayCast3D  = $DamageRay

@export var speed: float = 50.0


func _process(delta: float) -> void:
	position.x += speed * delta
	
	if damage_ray.is_colliding():
		var collider := damage_ray.get_collider()
		var health := collider.get_node_or_null("Health") as Health

		if health:
			health.damage(10.0)
