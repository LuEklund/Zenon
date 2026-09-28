class_name UnitScene
extends Resource

@export var kind: Unit.Kind
@export var scene: PackedScene

func _init(unit_kind: Unit.Kind, unit_scene: PackedScene) -> void:
	self.kind = unit_kind
	self.scene = unit_scene
