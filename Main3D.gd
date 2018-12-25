extends ImmediateGeometry

var rawData = [
	{"vertices":[
		{"pos":Vector3(0, 0, 0),"color":Color(1.0, 1.0, 1.0, 1.0),"uv":Vector2(0, 0)},
		{"pos":Vector3(0, 2, 0),"color":Color(1.0, 1.0, 1.0, 0.0),"uv":Vector2(0, 0)},
		{"pos":Vector3(4, 0, 0),"color":Color(1.0, 0.0, 0.0, 1.0),"uv":Vector2(0, 0)}
	],"tex":null}
]

func _ready():
	updateGeometry()

func updateGeometry():
	clear()
	for i in range(rawData.size()):
		var triangle = rawData[i]
		var texture = null
		if triangle["tex"] != null:
			texture = load(triangle["tex"])
		begin(Mesh.PRIMITIVE_TRIANGLES, texture)
		for j in range(triangle["vertices"].size()):
			var vertex = triangle["vertices"][j]
			set_color(vertex["color"])
			set_uv(vertex["uv"])
			add_vertex(vertex["pos"])
		end()