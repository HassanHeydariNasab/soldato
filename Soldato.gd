extends Node2D

var Kuglo = preload("res://Kugloj/Kuglo.tscn")
onready var Aspekto = get_node("Aspekto")
onready var Kuglo_elirejo = get_node("Kuglo_elirejo")
onready var Pafi_sono = get_node("Pafi_sono")
onready var Resxargxi_sono = get_node("Resxargxi_sono")
onready var Pafi_malplene_sono = get_node("Pafi_malplene_sono")
onready var Kuglujo = get_node("/root/Radiko/Kanvaso/Kuglujo")
onready var Kuglujoj = get_node("/root/Radiko/Kanvaso/Kuglujoj")
onready var Kamero = get_node("/root/Radiko/Kamero")
onready var Kuglo_flanko = get_node("/root/Radiko/Kuglo_flanko")
onready var Vivo = get_node("Vivo")

var animeto = false

var kuglujoj = 10
var kugloj = 7

var pafebla = true

var Malamikoj = []

const VIVO = 20.0
var vivo = 20.0

func _ready():
	Kamero.set_offset(get_global_pos())
	Aspekto.play("senkulpa")
	set_process(true)
	set_process_input(true)

func _process(delta):
	if Input.is_action_pressed("supre") or Input.is_action_pressed("malsupre") or\
	Input.is_action_pressed("dekstre") or Input.is_action_pressed("maldekstre"):
		Kamero.set_offset(get_global_pos())
		Kuglo_flanko.set_global_pos(get_global_pos())
		if not animeto:
			Aspekto.set_animation("movi")
	else:
		if not animeto:
			Aspekto.set_animation("senkulpa")
	if Input.is_action_pressed("supre"):
		move(Vector2(0,-4))
	if Input.is_action_pressed("malsupre"):
		move(Vector2(0,4))
	if Input.is_action_pressed("dekstre"):
		move(Vector2(4,0))
	if Input.is_action_pressed("maldekstre"):
		move(Vector2(-4,0))

func pafi():
	if kugloj > 0 and pafebla:
		animeto = true
		Aspekto.set_animation("pafi")
		kugloj -= 1
		Kuglujo.set_value(kugloj)
		var Kuglo_ = Kuglo.instance()
		Kuglo_.set_global_pos(Kuglo_elirejo.get_global_pos())
		Kuglo_.angulo = get_rot()-PI/2.0
		T.Radiko.Kugloj.add_child(Kuglo_)
		Pafi_sono.play()
	else:
		Pafi_malplene_sono.play()

func resxargxi():
	if kuglujoj > 0:
		pafebla = false
		animeto = true
		Aspekto.set_animation("resxargxi")
		Resxargxi_sono.play()

func _input(evento):
	if evento.is_action_pressed("Resxargxi"):
		resxargxi()
	elif T.os == "Android":
		if evento.type == InputEvent.SCREEN_TOUCH:
			if evento.is_pressed() and evento.index != 2 and\
			evento.pos.y < 900:
				look_at(evento.pos+get_global_pos()-Vector2(300,600))
				pafi()
		elif evento.type == InputEvent.SCREEN_DRAG:
			if evento.pos.y < 900:
				look_at(evento.pos+get_global_pos()-Vector2(300,600))
	else:
		if evento.type == InputEvent.MOUSE_BUTTON:
			if evento.button_index == BUTTON_LEFT and evento.is_pressed():
				pafi()
			elif evento.button_index == BUTTON_RIGHT and evento.is_pressed() and\
			kuglujoj > 0:
				resxargxi()
		elif evento.type == InputEvent.MOUSE_MOTION:
			look_at(get_global_mouse_pos())

func _on_Aspekto_finished():
	var a = Aspekto.get_animation()
	if a == "pafi":
		animeto = false
	elif a == "resxargxi":
		pafebla = true
		animeto = false
		kuglujoj -= 1
		kugloj = 7
		Kuglujo.set_value(7)
		Kuglujoj.set_text(str(kuglujoj))

func _je_zombio_atakis():
	vivo -= 2
	if vivo <= 0:
		get_tree().reload_current_scene()
	Vivo.set_scale(Vector2(vivo/VIVO,1))