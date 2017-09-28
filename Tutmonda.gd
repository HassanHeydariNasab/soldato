extends Node

onready var Radiko = null
var os = OS.get_name()

func _ready():
	pass

func get_layer_bit (korpo, bit):
	if korpo extends KinematicBody2D:
		return korpo.get_layer_mask_bit(bit)
	elif korpo extends TileMap:
		return korpo.get_collision_layer_bit(bit)