extends Node2D

var font = load("res://font.tres")

var dt = 1
var fps = 0
var moveMode = true
var objectCount = 1

func _ready():
	set_process(true)
	set_process_input(true)

func _process(delta):
	dt = delta
	fps = (fps * 0.9) + ((1 / dt) * 0.1)
	update()
	
	$Main3D.rawData = []
	for i in range(objectCount):
		$Main3D.rawData.append({"vertices":[
			{"pos":Vector3(0, 0, 0),"color":Color(1.0, 1.0, 1.0, 1.0),"uv":Vector2(0, 0)},
			{"pos":Vector3(0, 2, 0),"color":Color(1.0, 1.0, 1.0, 0.0),"uv":Vector2(0, 0)},
			{"pos":Vector3(4, 0, 0),"color":Color(1.0, 0.0, 0.0, 1.0),"uv":Vector2(0, 0)}
		],"tex":null})
	$Main3D.updateGeometry()

func _input(event):
	if event.is_action_pressed("ui_change_mode"):
		toggleMoveMode()
	if event.is_action_pressed("ui_exit"):
		get_tree().quit()

func toggleMoveMode():
	moveMode = !moveMode
	System.holdMouse = moveMode

func _draw():
	draw_string(font, Vector2(0, 12), "Camera:", Color(1.0, 1.0, 1.0))
	draw_string(font, Vector2(8, 24), "Position: " + str($Camera.translation), Color(1.0, 1.0, 1.0))
	draw_string(font, Vector2(8, 36), "Rotation: " + str($Camera.rotation), Color(1.0, 1.0, 1.0))
	draw_string(font, Vector2(0, 48), "Mouse:", Color(1.0, 1.0, 1.0))
	draw_string(font, Vector2(8, 60), "Position: " + str(System.mousePos), Color(1.0, 1.0, 1.0))
	draw_string(font, Vector2(8, 72), "Delta: " + str(System.mousePosDelta), Color(1.0, 1.0, 1.0))
	draw_string(font, Vector2(0, 96), "FPS: " + str(floor(fps)), Color(1.0, 1.0, 1.0))
	drawSlider(Vector2(8, 104), Vector2(128, 16), "objectCount", 0, 20)
	draw_string(font, Vector2(0, 136), "Object count: " + str(objectCount), Color(1.0, 1.0, 1.0))

func drawSlider(pos, size, valueName, minValue, maxValue):
	var valuePercent = get(valueName) / float(maxValue - minValue)
	var sliderRect = Rect2(pos, size)
	var sliderFillRect = Rect2(pos, size * Vector2(valuePercent, 1))
	var sliderHandleRect = Rect2(pos + Vector2((size[0] * valuePercent) - 4, -4), Vector2(8, size[1] + 8))
	var sliderHandleSelected = sliderHandleRect.has_point(System.mousePos) && !moveMode
	var sliderHandleMove = (sliderRect.has_point(System.mousePos) && System.mouseClicked) && !moveMode
	draw_rect(sliderRect, Color(1.0, 1.0, 1.0), false)
	draw_rect(sliderFillRect, Color(0.0, 1.0, 0.0, 0.5), true)
	if !sliderHandleSelected:
		draw_rect(sliderHandleRect, Color(0.5, 0.5, 0.5), true)
	draw_rect(sliderHandleRect, Color(1.0, 1.0, 1.0), sliderHandleSelected)
	if sliderHandleMove:
		var newValuePercent = (System.mousePos[0] - pos[0]) / float(size[0])
		var newValue = round(minValue + ((maxValue - minValue) * newValuePercent))
		set(valueName, newValue)