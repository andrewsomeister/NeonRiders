extends Line2D

func _ready() -> void:
	var line_poly = Geometry2D.offset_polyline(points, width / 2, Geometry2D.JOIN_ROUND, Geometry2D.END_ROUND)
	
	# offset_polyline_2d can potentially return multiple polygons
	# so iterate through all polyons and create collision shapes from them
	for poly in line_poly:
		var col = CollisionPolygon2D.new()
		col.polygon = poly
		$StaticBody2D.add_child(col)
