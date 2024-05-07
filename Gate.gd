extends Area2D

signal player_entered  # Signal to proceed to the next level

@onready var gate_sprite = $Gate  # Adjust to the correct node
@onready var global = get_node("/root/Global")


func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))
	connect("body_exited", Callable(self, "_on_body_exited"))  # Make sure this line is present


func _on_body_entered(body):
	if (body.name == "Player1" or body.name == "Player2") and global.coins_collected == global.total_coins:
		gate_sprite.modulate = Color.GREEN  # Change gate color to green
		global.gates_triggered += 1
		print("gate triggered +1")


func _on_body_exited(body):
	if (body.name == "Player1" or body.name == "Player2") and global.coins_collected == global.total_coins:
		gate_sprite.modulate = Color.BLUE  # Change gate color back to blue
		global.gates_triggered -= 1
		print("gate triggered -1")
