extends Node2D

onready var Soldato = get_node("Soldato")
onready var Kugloj = get_node("Kugloj")
onready var Kamero = get_node("Kamero")

func _ready():
	T.Radiko = self

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
