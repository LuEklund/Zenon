class_name Player
extends Node

signal spawn_unit(scene: PackedScene)

const PATH_PREFIX = "res://scenes/units/"

@export var miner: PackedScene = load(PATH_PREFIX + "miner.tscn")
@export var swordsman: PackedScene = load(PATH_PREFIX + "swordsman.tscn")
@export var archer: PackedScene = load(PATH_PREFIX + "archer.tscn")
