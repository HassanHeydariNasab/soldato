extends Node2D

onready var Soldato = get_node("Soldato")
onready var Kugloj = get_node("Kugloj")
onready var Kuglujo = get_node("Kanvaso/Kuglujo")
onready var Kuglujoj = get_node("Kanvaso/Kuglujoj")
onready var Kamero = get_node("Kamero")
onready var Kuglo_flanko = get_node("Kuglo_flanko")
onready var Kuglo_flanko_tempilo = get_node("Kuglo_flanko_tempilo")
onready var Montrilo = get_node("Kanvaso/Centro/Montrilo")
onready var Finejo1 = get_node("Finejo1")
var Finejo2 = null
onready var Preni_sono = get_node("Preni_sono")
onready var Organoj1 = get_node("Organoj1")
onready var Organoj2 = get_node("Organoj2")
onready var Organoj3 = get_node("Organoj3")

var L1 = null
var L2 = null

func _ready():
	T.Radiko = self
	if has_node("Finejo2"):
		Finejo2 = get_node("Finejo2")
	Kuglujo.set_value(Soldato.kugloj)
	Kuglujoj.set_text(str(Soldato.kuglujoj))
	set_process(true)

func _on_Dekstre_Supre_pressed():
	Input.action_press("dekstre")
	Input.action_press("supre")

func _on_Dekstre_Supre_released():
	Input.action_release("dekstre")
	Input.action_release("supre")

func _on_Dekstre_Malsupre_pressed():
	Input.action_press("dekstre")
	Input.action_press("malsupre")

func _on_Dekstre_Malsupre_released():
	Input.action_release("dekstre")
	Input.action_release("malsupre")

func _on_Maldekstre_Supre_pressed():
	Input.action_press("maldekstre")
	Input.action_press("supre")

func _on_Maldekstre_Supre_released():
	Input.action_release("maldekstre")
	Input.action_release("supre")

func _on_Maldekstre_Malsupre_pressed():
	Input.action_press("maldekstre")
	Input.action_press("malsupre")

func _on_Maldekstre_Malsupre_released():
	Input.action_release("maldekstre")
	Input.action_release("malsupre")

func _on_Malaktivigi_toggled( b ):
	Soldato.pafebla = not(b)

func _on_Resxargxi_pressed():
	Soldato.resxargxi()

func _on_Kuglo_flanko_tempilo_timeout():
	Kuglo_flanko.hide()

func _process(delta):
	L1 = Finejo1.get_global_pos() - Soldato.get_global_pos()
	if Finejo2 != null:
		L2 = Finejo2.get_global_pos() - Soldato.get_global_pos()
		if L1.length() < L2.length():
			Montrilo.set_rot(atan2(L1.x,L1.y))
		else:
			Montrilo.set_rot(atan2(L2.x,L2.y))
	else:
		Montrilo.set_rot(atan2(L1.x,L1.y))

func _je_zombio_mortigxis(loko):
	randomize()
	if randi() % 2 == 0:
		Organoj1.set_global_pos(loko)
		Organoj1.show()
	elif randi() % 3 == 0:
		Organoj3.set_global_pos(loko)
		Organoj3.show()
	else:
		Organoj2.set_global_pos(loko)
		Organoj2.show()