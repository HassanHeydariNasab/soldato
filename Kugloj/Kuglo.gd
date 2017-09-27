extends Node2D

var angulo = 0
const RAPIDO = 10

func _ready():
	set_rot(angulo-PI/2)
	set_process(true)

func _process(delta):
	translate(Vector2(RAPIDO*cos(angulo), -RAPIDO*sin(angulo)))

func _on_Areo_body_enter( korpo ):
	korpo.queue_free()
	queue_free()

func _on_Vivo_tempilo_timeout():
	queue_free()