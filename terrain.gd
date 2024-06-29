extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Destructible/CollisionPolygon2D.polygon = $Rock.polygon

func clip_cur_island(drill_poly, island, collision):
	var offset_poly = Polygon2D.new()
	offset_poly.global_position = Vector2.ZERO
	var new_values = []
	for point in drill_poly.polygon:
		new_values.append((drill_poly.global_transform * point))
	offset_poly.polygon = PackedVector2Array(new_values)
	var res = Geometry2D.clip_polygons(island.polygon, offset_poly.polygon)
	# Deletes node if the clip covers all of it. Otherwise sets node polygon.
	if res.is_empty():
		island.call_deferred("queue_free")
		collision.call_deferred("queue_free")
	else:
		island.polygon = res[0]
		collision.set_deferred("polygon", res[0])
	return res

# Adds Polygon 2D as child of terrain and 
# collision polygon as child of destructible
func split_terrain(islands):
	for i in range(1, len(islands)):
			var new_island := Polygon2D.new()
			new_island.polygon = islands[i]
			self.add_child(new_island)
			var new_collision_polygon := CollisionPolygon2D.new()
			new_collision_polygon.polygon = new_island.polygon
			new_collision_polygon.add_to_group("Destructibles")
			new_island.set_deferred("color", Color(0.333, 0.173, 0.043))
			$Destructible.call_deferred("add_child", new_collision_polygon)

func clip(drill_poly):
	var all_islands = self.get_children().filter(func(node): return node is Polygon2D)
	var all_collisions = $Destructible.get_children().filter(func(node): return node is CollisionPolygon2D)
	for i in range(0, len(all_islands)):
		#Does the clip of current island
		var result_islands = clip_cur_island(drill_poly, all_islands[i], all_collisions[i])
		
		#If result of clip leaves more than one island, create new island(s)
		if result_islands.size() > 1:
			split_terrain(result_islands)
