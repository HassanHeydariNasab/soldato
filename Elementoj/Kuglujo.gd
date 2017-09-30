extends Node2D

func _ready():
	pass

func _on_Areo_body_enter( korpo ):
	korpo.kuglujoj += 1
	korpo.Kuglujoj.set_text(str(korpo.kuglujoj))
	queue_free()
