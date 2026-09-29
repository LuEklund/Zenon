class_name HumanPlayer
extends Player

const HUD: PackedScene = preload("res://scenes/ui/hud.tscn")

var hud: Control

func _ready() -> void:
	hud = HUD.instantiate()
	add_child(hud)
	var spawn = hud.get_node("Spawn") as Control
	
	(spawn.get_node("Miner") as TextureButton).pressed.connect(_spawn.bind(miner))
	(spawn.get_node("Swordsman") as TextureButton).pressed.connect(_spawn.bind(swordsman))
	(spawn.get_node("Archer") as TextureButton).pressed.connect(_spawn.bind(archer))

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("spawn_miner"): _spawn(miner)
	if event.is_action_pressed("test"): _spawn(swordsman)

func _spawn(scene: PackedScene) -> void:
	spawn_unit.emit(scene)
