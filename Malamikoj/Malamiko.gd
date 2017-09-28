extends KinematicBody2D

var speed = 150
var nav = null
var path = []
var goal = Vector2()

func _ready():
	goal = get_node("/root/Radiko/Soldato").get_global_pos()
	nav = get_node("/root/Radiko/Nav")
	update_path()
	set_process(true)
	pass

func update_path():
	path = nav.get_simple_path(get_pos(), goal, false)
	if path.size() == 0:
		pass

func _process(delta):
	if path.size() > 1:
		var d = get_pos().distance_to(path[0])
		if d > 2:
			set_pos(get_pos().linear_interpolate(path[0], (speed * delta)/d))
		else:
			path.remove(0)
	else:
		pass

func _on_Nav_tempilo_timeout():
	goal = get_node("/root/Radiko/Soldato").get_global_pos()
	update_path()
