extends Area3D

@export var forest_scene = preload("res://Levels/level.tscn")
@onready var game_handler: Node3D = $"../Environment/GameHandler"

func _on_body_entered(body: Node3D) -> void:
	if body is Player:
		get_tree().change_scene_to_file("res://Levels/level.tscn")
		GameStates.player_location = "Forest"

