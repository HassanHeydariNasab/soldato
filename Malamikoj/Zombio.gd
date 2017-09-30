extends KinematicBody2D

onready var Aspekto = get_node("Aspekto")
onready var Nav_tempilo = get_node("Nav_tempilo")
onready var Vivo = get_node("Vivo")

const RAPIDO = 180
var nav = null
var vojo = []
var celo = Vector2()

var animeto = false

const VIVO = 7.0
var vivo = 7.0

func _ready():
	celo = get_node("/root/Radiko/Soldato").get_global_pos()
	nav = get_node("/root/Radiko/Nav")
	Aspekto.play("senkulpa")
	set_fixed_process(true)

func rekalkuli_vojon():
	vojo = nav.get_simple_path(get_pos(), celo, false)

func _process(delta):
	if vojo.size() > 1:
		var d = get_pos().distance_to(vojo[0])
		if d > 2:
			move_to(get_pos().linear_interpolate(vojo[0], (RAPIDO * delta)/d))
			if not animeto:
				Aspekto.set_animation("movi")
		else:
			vojo.remove(0)
			look_at(celo)
	else:
		if not animeto:
			Aspekto.set_animation("senkulpa")

func _on_Nav_tempilo_timeout():
	celo = get_node("/root/Radiko/Soldato").get_global_pos()
	rekalkuli_vojon()

func _on_Aspekto_finished():
	var a = Aspekto.get_animation()
	if a == "ataki":
		T.Radiko.Soldato._je_zombio_atakis()

func _on_Videjo_body_enter( korpo ):
	Nav_tempilo.start()
	set_process(true)

func _on_Videjo_body_exit( korpo ):
	Aspekto.set_animation("senkulpa")
	Nav_tempilo.stop()
	set_process(false)

func _on_Atakejo_body_enter( korpo ):
	if T.get_layer_bit(korpo, 1):
		animeto = true
		look_at(celo)
		Aspekto.set_animation("ataki")

func _on_Atakejo_body_exit( korpo ):
	if T.get_layer_bit(korpo, 1):
		animeto = false
