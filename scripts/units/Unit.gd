class_name Unit
extends StaticBody3D

enum Kind {
	MINER,
	GOBLIN_MAN, # tmp
}

signal attacking(target: Unit)
signal damaged(attacker: Unit, amount: float)
signal died

@export var team: int = 0
@export var kind: Kind
@export var health: float = 100.0
@export var player: Player


func attack(target: Unit, amount: float) -> void:
	if not is_instance_valid(target):
		return
	if target == self or amount <= 0.0:
		return

	target.damage(self, amount)
	attacking.emit(target)


func damage(attacker: Unit, amount: float) -> void:
	if not is_instance_valid(attacker):
		return
	if health <= 0.0 or amount <= 0.0:
		return

	health = maxf(health - amount, 0.0)
	damaged.emit(attacker, amount)

	if health == 0.0:
		died.emit()


func team_collision_layer() -> int:
	var group := 0 if team < 2 else 2
	var side := team if team < 2 else team - 3
	return 1 << (group + side)


func enemy_collision_mask() -> int:
	var group := 0 if team < 2 else 2
	var side := team if team < 2 else team - 3
	return 1 << (group + (1 - side))
