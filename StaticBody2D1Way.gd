extends StaticBody2D

var line: Line2D

func _ready() -> void:
	collision_layer = 1
	collision_mask = 1
	line = $Line2D

	# Generate collision polygons from the Line2D node
	var line_poly = Geometry2D.offset_polyline(line.points, line.width / 2, Geometry2D.JOIN_ROUND, Geometry2D.END_ROUND)

	# Iterate through all polygons and create collision shapes
	for poly in line_poly:
		var col = CollisionPolygon2D.new()
		col.polygon = poly
		col.one_way_collision = true  # Enable one-way collision
		col.one_way_collision_margin = 5.0  # Optional: Set margin to avoid getting stuck at edges
		add_child(col)  # Add the collision shape to StaticBody2D
