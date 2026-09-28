class_name Player
extends Node3D

@onready var statue: Unit = $Statue
@onready var spawner: Node3D = $Spawner

var controller: PlayerController
var team: int

var gold: float = 900.0:
	set(value):
		gold = value

		var hud = get_node("Hud")
		if hud:
			var label := hud.get_node("Gold") as Label
			label.text = "$" + str(gold)

	get:
		return gold

func spawn(new_controller: PlayerController, new_team: int) -> void:
	assert(new_controller != null, "Player requires a controller")
	controller = new_controller
	controller.spawn_unit.connect(_on_spawn_unit)
	
	team = new_team
	statue.team = team

func _on_spawn_unit(unit_kind: Unit.Kind) -> void:
	var scene := controller.get_scene(unit_kind)
	assert(scene != null)
	
	var unit := scene.instantiate() as Unit
	assert(
		unit != null,
		"Unit scene does not have a Unit root: type=%s, scene=%s"
			% [unit_kind, scene.resource_path.get_file()]
	)
	
	unit.player = self
	unit.kind = unit_kind

	if unit_kind != Unit.Kind.MINER: unit.team = team

	spawner.add_child(unit)
