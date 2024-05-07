extends Control

func _ready():
	# Connect the Play button's signal
	$PlayButton.connect("pressed", Callable(self, "_on_play_button_pressed"))

# Function to handle the Play button click
func _on_play_button_pressed():
	# Load the first level
	get_tree().change_scene("res://path/to/first_level_scene.tscn")
