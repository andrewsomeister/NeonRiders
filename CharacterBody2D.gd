extends CharacterBody2D

const MAX_SPEED = 300.0
const JUMP_VELOCITY = -400.0
const RESET_SPEED = 0.15  # Adjust for smoother reset
const ANGLE_THRESHOLD = deg_to_rad(60)  # Adjust threshold to prevent jitter

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var front_wheel_ray = $FrontRayCast2D
@onready var rear_wheel_ray = $RearRayCast2D
@onready var bike_sprite = $BikeSprite

func _physics_process(delta):
	# Apply gravity
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get input direction and handle movement
	var direction = Input.get_axis("move_left_p1", "move_right_p1")
	if direction:
		velocity.x = direction * MAX_SPEED
		bike_sprite.scale.x = -1 if direction < 0 else 1
	else:
		velocity.x = 0

	# Determine target rotation based on ground slope
	var target_angle = rotation

	if front_wheel_ray.is_colliding() or rear_wheel_ray.is_colliding():
		var front_normal = front_wheel_ray.get_collision_normal() if front_wheel_ray.is_colliding() else Vector2()
		var rear_normal = rear_wheel_ray.get_collision_normal() if rear_wheel_ray.is_colliding() else Vector2()

		# Average the normals if both are present, or use the single normal
		var normal = (front_normal + rear_normal).normalized()
		
		if normal != Vector2():
			target_angle = normal.angle() + PI / 2
	else:
		# No ground detected, return to flat
		target_angle = 0

	# Apply rotation change only if significant
	if abs(target_angle - rotation) < ANGLE_THRESHOLD:
		rotation = lerp_angle(rotation, target_angle, RESET_SPEED)

	# Move the bike
	move_and_slide()
