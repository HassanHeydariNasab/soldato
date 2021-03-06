extends Node2D

onready var Kasxi = get_node("Kasxi")

func _ready():
	Kasxi.interpolate_property(self, "transform/scale", Vector2(1,1),
	Vector2(2,2), 0.1, Tween.TRANS_QUAD, Tween.EASE_OUT_IN
	)
	Kasxi.interpolate_property(self, "visibility/opacity", 1,
	0, 0.1, Tween.TRANS_QUAD, Tween.EASE_OUT_IN
	)

func _on_Areo_body_enter( korpo ):
	get_node("Areo").clear_shapes()
	T.Radiko.Preni_sono.play()
	korpo.kuglujoj += 1
	korpo.Kuglujoj.set_text(str(korpo.kuglujoj))
	Kasxi.start()

func _on_Kasxi_tween_complete( object, key ):
	queue_free()
