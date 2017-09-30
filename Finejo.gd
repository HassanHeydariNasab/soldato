extends Node2D

func _ready():
	pass

func _on_Areo_body_enter( korpo ):
	get_tree().reload_current_scene()