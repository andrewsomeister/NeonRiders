extends RigidBody2D

# Variable to hold the Line2D node
var line

func _ready():
	# Assign the Line2D node
	line = $Line2D

	# Store the line's global position
	var line_global_position = line.global_position

	# Generate collision polygons from the Line2D node
	var line_poly = Geometry2D.offset_polyline(line.points, line.width / 2, Geometry2D.JOIN_ROUND, Geometry2D.END_ROUND)

	# Calculate the line center
	var line_center = get_line_center()
	global_position += line_center + line.position

	# Restore the line's global position
	line.global_position = line_global_position

	# Create collision shapes from the generated polygons
	for poly in line_poly:
		var collision_shape = CollisionPolygon2D.new()
		collision_shape.polygon = offset_line_points(line_center, poly)
		add_child(collision_shape)

# Offset the points of the polygon by the center of the line
func offset_line_points(center: Vector2, poly: Array) -> Array:
	var adjusted_points = []
	for point in poly:
		adjusted_points.append(point - center)
	return adjusted_points

# A simple weighted average of all points of the Line2D to find the center
func get_line_center() -> Vector2:
	var center_weight = line.points.size()
	var center = Vector2.ZERO

	for point in line.points:
		center.x += point.x / center_weight
		center.y += point.y / center_weight

	return center
