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
		var mouseHoldPos = (windowSize / 2).floor()
		mousePosDelta = mousePos - mouseHoldPos
		Input.warp_mouse_position(mouseHoldPos)
	else:
		mousePosDelta = mousePos - oldMousePos