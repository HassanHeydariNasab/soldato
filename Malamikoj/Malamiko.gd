extends KinematicBody2D

var Kuglo = preload("res://Kugloj/Kuglo.tscn")
onready var Aspekto = get_node("Aspekto")
onready var Kuglo_elirejo = get_node("Kuglo_elirejo")
onready var Pafi_sono = get_node("Pafi_sono")
onready var Resxargxi_sono = get_node("Resxargxi_sono")
onready var Pafi_malplene_sono = get_node("Pafi_malplene_sono")
onready var Nav_tempilo = get_node("Nav_tempilo")
onready var Pafi_tempilo = get_node("Pafi_tempilo")

const RAPIDO = 150
var nav = null
var vojo = []
var celo = Vector2()

var animeto = false

var kuglujoj = 99
var kugloj = 7

var pafebla = false

func _ready():
	celo = get_node("/root/Radiko/Soldato").get_global_pos()
	nav = get_node("/root/Radiko/Nav")
	Aspekto.play("senkulpa")
	set_fixed_process(true)
	pass

func rekalkuli_vojon():
	vojo = nav.get_simple_path(get_pos(), celo, false)
	if vojo.size() == 0:
		pass

func _process(delta):
	if vojo.size() > 1:
		var d = get_pos().distance_to(vojo[0])
		if d > 350:
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

func pafi():
	print(1)
	if kugloj > 0:
		animeto = true
		Aspekto.set_animation("pafi")
		kugloj -= 1
		var Kuglo_ = Kuglo.instance()
		Kuglo_.set_global_pos(Kuglo_elirejo.get_global_pos())
		Kuglo_.angulo = get_rot()-PI/2.0
		T.Radiko.Kugloj.add_child(Kuglo_)
		Pafi_sono.play()
	else:
		resxargxi()

func resxargxi():
	if kuglujoj > 0:
		animeto = true
		Aspekto.set_animation("resxargxi")
		kuglujoj -= 1
		kugloj = 7
		Resxargxi_sono.play()

func _on_Aspekto_finished():
	var a = Aspekto.get_animation()
	if a == "pafi" or a == "resxargxi":
		animeto = false

func _on_Videjo_body_enter( korpo ):
	Nav_tempilo.start()
	set_process(true)
	pafebla = true
	Pafi_tempilo.start()

func _on_Videjo_body_exit( korpo ):
	pafebla = false

func _on_Pafi_tempilo_timeout():
	if pafebla:
		pafi()
