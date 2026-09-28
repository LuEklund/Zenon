extends Unit

@onready var damage_ray: RayCast3D = $DamageRay

@export var speed: float = 5.0
@export var damage_amount: float = 30.0 / 60.0
@export var range_: float = 1.0

func _ready() -> void:
	died.connect(_on_died)
	
	collision_layer = team_collision_layer()
	damage_ray.collision_mask = enemy_collision_mask()

func _physics_process(delta: float) -> void:
	var target := get_target()

	if target == null:
		position.x += speed * delta
	else:
		attack(target, damage_amount)


func get_target() -> Unit:
	if not damage_ray.is_colliding(): return null

	var target = damage_ray.get_collider() as Unit
	if target == null or target.team == team: return null
	return target

func _on_died() -> void:
	queue_free()
