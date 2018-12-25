extends Camera

var speed = 1
var movement = {"right":false,"left":false,"up":false,"down":false,"backward":false,"forward":false}
var mouseSensitivity = 1

func _ready():
	set_process(true)
	set_process_input(true)

func _process(delta):
	if System.main.moveMode:
		for i in range(movement.size()):
			var movementName = movement.keys()[i]
			if !movement[movementName]:
				continue
			var translationBase = Vector3(0, 0, 0)
			var frameSpeed = speed * delta
			if i % 2 == 1:
				frameSpeed *= -1
			translationBase[floor(i / 2)] = frameSpeed
			translate(translationBase)
		rotation -= Vector3((System.mousePosDelta[1] * mouseSensitivity) * 0.002, (System.mousePosDelta[0] * mouseSensitivity) * 0.002, 0)

func _input(event):
	for i in range(movement.size()):
		var movementName = movement.keys()[i]
		if event.is_action_pressed("camera_" + movementName):
			movement[movementName] = true
		if event.is_action_released("camera_" + movementName):
			movement[movementName] = false