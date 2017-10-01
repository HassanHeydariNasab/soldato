extends Node2D

var angulo = 0
const RAPIDO = 25

func _ready():
	set_rot(angulo-PI/2)
	set_process(true)

func _process(delta):
	translate(Vector2(RAPIDO*cos(angulo), -RAPIDO*sin(angulo)))

func _on_Areo_body_enter( korpo ):
	if T.get_layer_bit(korpo,2) or T.get_layer_bit(korpo,1):
		korpo.vivo -= 1
		korpo.Vivo.set_scale(Vector2(korpo.vivo/korpo.VIVO,1))
		if T.get_layer_bit(korpo,1):
			T.Radiko.Kuglo_flanko.show()
			T.Radiko.Kuglo_flanko.set_rot(angulo+PI/2)
			T.Radiko.Kuglo_flanko_tempilo.start()
		elif T.get_layer_bit(korpo,2):
			korpo.Nav_tempilo.start()
			korpo.set_process(true)
			korpo.Sango.set_emitting(true)
		if korpo.vivo <= 0:
			if T.get_layer_bit(korpo,1):
				get_tree().reload_current_scene()
			else:
				korpo.queue_free()
	queue_free()

func _on_Vivo_tempilo_timeout():
	queue_free()