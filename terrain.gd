extends Node2D

@onready var terrain = $Destructible
@onready var ColPol = preload("res://map.tscn")
@export var map: PackedScene

func _ready() -> void:
	var loaded_map = ColPol.instantiate()
	add_child(loaded_map)
	var polygon_list = loaded_map.get_children().filter(func(node): return node is Polygon2D)
	for polygon in polygon_list:
		new_col_pol(polygon)

func clip(poly):
	var offset_poly = Polygon2D.new()
	offset_poly.polygon = poly.global_transform * (poly.polygon)
	
	var colpol_list = terrain.get_children().filter(func(node): return node is CollisionPolygon2D)
	for colpol in colpol_list:
		var curr_poly = colpol.get_node("Polygon2D")
		var res = Geometry2D.clip_polygons(curr_poly.polygon, offset_poly.polygon)

		#If res empty, the explosion will consume the polygon
		if res.is_empty():
			colpol.call_deferred("queue_free")
		else:
			curr_poly.polygon = res[0]
			colpol.set_deferred("polygon", res[0])
				
			# If res larger than 1, new islands will be created
			if res.size() > 1:
					for i in range(1, len(res)):
						var island := Polygon2D.new()
						island.polygon = res[i]
						new_col_pol(island)

	offset_poly.queue_free()

func new_col_pol(polygon):
	var ColPol = ColPol.instantiate()
	ColPol.polygon = polygon.polygon
	terrain.add_child(ColPol)
## Called when the node enters the scene tree for the first time.
#func _ready():
	#$Destructible/CollisionPolygon2D.polygon = $Rock.polygon
#
#
#func clip(poly):
	#var offset_poly = Polygon2D.new()
	#offset_poly.global_position = Vector2.ZERO
	#
	#var new_values = []
	#for point in poly.polygon:
		#new_values.append((poly.global_transform * point))
	#offset_poly.polygon = PackedVector2Array(new_values)
	#
	#var res = Geometry2D.clip_polygons($Rock.polygon, offset_poly.polygon)
	#
	#$Rock.polygon = res[0]
	#$Destructible/CollisionPolygon2D.set_deferred("polygon", res[0])
