extends Node2D
@onready var global = get_node("/root/Global")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if global.gates_triggered == 2:
		get_tree().change_scene_to_file("res://Level2.tscn")
