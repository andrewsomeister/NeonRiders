extends MenuButton

func _ready():
	# Use Callable to connect the pressed signal
	connect("pressed", Callable(self, "_on_button_pressed"))

func _process(delta):
	pass  # Use this for any per-frame logic if needed

# Function to handle the button press
func _on_button_pressed():
	# Load the first level
	get_tree().change_scene_to_file("res://Level1.tscn")
