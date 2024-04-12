extends Node3D

@onready var player: CharacterBody3D = $"../../Player"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	handleGameSettingClicks()
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()

func _on_player_tree_exiting() -> void:
	get_tree().reload_current_scene()

func handleGameSettingClicks():
	if Input.is_action_just_pressed("reload_scene"):
		get_tree().reload_current_scene()
