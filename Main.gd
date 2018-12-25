extends Node2D

var font = load("res://font.tres")

var dt = 1
var fps = 0
var moveMode = true

func _ready():
	set_process(true)
	set_process_input(true)

func _process(delta):
	dt = delta
	fps = (fps * 0.9) + ((1 / dt) * 0.1)
	update()

func _input(event):
	if event.is_action_pressed("ui_change_mode"):
		toggleMoveMode()
	if event.is_action_pressed("ui_exit"):
		get_tree().quit()

func _draw():
	draw_string(font, Vector2(0, 12), "Camera:", Color(1.0, 1.0, 1.0))
	draw_string(font, Vector2(8, 24), "Position: " + str($Camera.translation), Color(1.0, 1.0, 1.0))
	draw_string(font, Vector2(8, 36), "Rotation: " + str($Camera.rotation), Color(1.0, 1.0, 1.0))
	draw_string(font, Vector2(0, 48), "Mouse:", Color(1.0, 1.0, 1.0))
	draw_string(font, Vector2(8, 60), "Position: " + str(System.mousePos), Color(1.0, 1.0, 1.0))
	draw_string(font, Vector2(8, 72), "Delta: " + str(System.mousePosDelta), Color(1.0, 1.0, 1.0))
	draw_string(font, Vector2(0, 96), "FPS: " + str(floor(fps)), Color(1.0, 1.0, 1.0))

func toggleMoveMode():
	moveMode = !moveMode
	System.holdMouse = moveMode