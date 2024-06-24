extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Destructible/CollisionPolygon2D.polygon = $Rock.polygon


func clip(poly):
	var offset_poly = Polygon2D.new()
	offset_poly.global_position = Vector2.ZERO
	
	var new_values = []
	for point in poly.polygon:
		new_values.append(point+poly.global_position)
	offset_poly.polygon = PackedVector2Array(new_values)
	
	var res = Geometry2D.clip_polygons($Rock.polygon, offset_poly.polygon)
	
	$Rock.polygon = res[0]
	$Destructible/CollisionPolygon2D.set_deferred("polygon", res[0])
