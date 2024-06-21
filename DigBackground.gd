extends Polygon2D


func _draw():
	var start = get_node("/root/Main/Player").position
	print(start)
	var fin = get_node("/root/Main/Player").position
	draw_line(start,fin,Color(0,0,0),20)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	queue_redraw()
