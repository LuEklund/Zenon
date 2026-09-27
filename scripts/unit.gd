class_name Unit
extends CharacterBody3D

enum Team {
	SELF,
	ENEMY,
}

@onready var health: Health  = $Health
@onready var damage_ray: RayCast3D  = $DamageRay

@export var team: Team = Team.SELF
@export var speed: float = 5.0
@export var damage: float = 30.0 / 60.0 # 30 dmg/s
@export var range: float = 1.0

var direction: Vector3

func _ready() -> void:
	if team == Team.SELF:
		direction = Vector3.RIGHT
		collision_layer = 1
		collision_mask = 2
	elif team == Team.ENEMY:
		direction = Vector3.LEFT
		collision_layer = 2
		collision_mask = 1

	damage_ray.target_position = direction * range
	damage_ray.collision_mask = collision_mask

func _physics_process(_delta: float) -> void:
	var attacking := false
	var target: Unit = null

	if damage_ray.is_colliding():
		var collider := damage_ray.get_collider()
		target = collider as Unit

		if target != null and target.team != team:
			attacking = true

	if attacking:
		velocity = Vector3.ZERO
	else:
		velocity = direction * speed

	move_and_slide()

	if attacking and target != null:
		var target_health := target.get_node_or_null("Health") as Health
		if target_health:
			target_health.damage(damage)
