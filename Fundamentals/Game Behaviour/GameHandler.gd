extends Node3D

@onready var player: CharacterBody3D = $"../../Player"
@onready var timer_return_home: Timer = $TimerReturnHome

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	handleGameSettingClicks()
	handle_return_home()
	handle_quit()

func _on_player_tree_exiting() -> void:
	get_tree().reload_current_scene()

func handleGameSettingClicks():
	if Input.is_action_just_pressed("reload_scene"):
		get_tree().reload_current_scene()

func handle_quit():
	if Input.is_action_just_pressed("close"):
		get_tree().quit()

func handle_return_home():
	if GameStates.player_location == "Forest":
		if Input.is_action_just_pressed("ReturnHome"):
			timer_return_home.start()
		if Input.is_action_just_released("ReturnHome") and !timer_return_home.is_stopped():
			timer_return_home.stop()

func _on_timer_return_home_timeout() -> void:
	GameStates.player_location = "Home"
	get_tree().change_scene_to_file("res://Levels/home.tscn")
