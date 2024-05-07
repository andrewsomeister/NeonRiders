extends Node

var coins_collected = 0
var total_coins = 6
var gates_triggered = 0
func restart_level1():
	coins_collected = 0
	gates_triggered = 0
	get_tree().change_scene_to_file("res://Level1.tscn")  # Replace with actual path

