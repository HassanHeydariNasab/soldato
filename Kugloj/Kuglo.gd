extends Node2D

var angulo = 0
const RAPIDO = 25

func _ready():
	set_rot(angulo-PI/2)
	set_process(true)

func _process(delta):
	translate(Vector2(RAPIDO*cos(angulo), -RAPIDO*sin(angulo)))

func _on_Areo_body_enter( korpo ):
	if T.get_layer_bit(korpo,2):
		korpo.queue_free()
	queue_free()

func _on_Vivo_tempilo_timeout():
	queue_free()