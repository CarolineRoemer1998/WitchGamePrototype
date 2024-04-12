extends Control

@onready var progress_bar: ProgressBar = $ProgressBar

@export var player : Player

func _process(delta) -> void:
	progress_bar.value = player.health_component.current_health
