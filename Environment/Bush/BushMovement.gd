extends StaticBody3D

@onready var animation_player_wind: AnimationPlayer = $AnimationPlayerWind


func _ready() -> void:
	animation_player_wind.play("Wind")


func _on_animation_player_wind_animation_finished(anim_name: StringName) -> void:
	animation_player_wind.play("Wind")
