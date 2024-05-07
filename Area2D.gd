extends Area2D

signal collected

@onready var audio_player = $AudioStreamPlayer
@onready var global = get_node("/root/Global")
@onready var timer = $Timer  # Assuming a Timer node is named "Timer"

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))
	timer.connect("timeout", Callable(self, "_on_timeout"))

func _on_body_entered(body):
	if body.name == "Player1" or body.name == "Player2":
		audio_player.play(0.5)
		global.coins_collected += 1
		emit_signal("collected")
		print("Playing sound and starting timer")
		timer.start()  # Start the timer to delay the queue_free call

func _on_timeout():
	queue_free()  # Remove the coin after the delay
