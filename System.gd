extends Node

onready var main = get_node("/root/Main")

var windowSize = Vector2(0, 0)
var mousePos = Vector2(0, 0)
var mousePosDelta = Vector2(0, 0)

var holdMouse = true

func _ready():
	set_process(true)

func _process(delta):
	windowSize = get_viewport().size
	var oldMousePos = mousePos
	mousePos = main.get_global_mouse_position()
	if holdMouse:
		mousePosDelta = mousePos - (windowSize / 2)
		Input.warp_mouse_position(windowSize / 2)
	else:
		mousePosDelta = mousePos - oldMousePos