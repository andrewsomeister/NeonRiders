extends Label

@onready var countdown_timer = $Timer  # Reference the main Timer node
@onready var delay_timer = $DelayTimer  # Reference the new delay Timer node
var countdown_time = 30  # Starting time in seconds
@onready var global = get_node("/root/Global")
func _ready():
	self.text = "Time Left: " + str(countdown_time)
	countdown_timer.connect("timeout", Callable(self, "_on_timer_timeout"))
	countdown_timer.start()

func _on_timer_timeout():
	countdown_time -= 1
	self.text = "Time Left: " + str(countdown_time)
	if countdown_time <= 0:
		countdown_timer.stop()  # Stop the main timer when it reaches zero
		self.text = "Time's up!"
		
		# Use the delay timer to add a 1-second delay before restarting
		delay_timer.wait_time = 1  # Set delay to 1 second
		delay_timer.one_shot = true  # Make the timer one-shot
		delay_timer.connect("timeout", Callable(self, "_delayed_restart"))
		delay_timer.start()

func _delayed_restart():
	global.restart_level1()
