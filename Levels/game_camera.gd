extends Camera3D

class_name Camera

@onready var player: Player = $"../../Player"

var current_position
var new_position
var is_moving = false

var t := 0.0

func _ready():
	current_position = global_position
	new_position = global_position

func _physics_process(delta: float) -> void:
	if current_position != new_position:
		player.is_active = false
		player.animation_player.play("idle")
		move_to_new_position(delta)
		

func move_to_new_position(delta: float):
	t += delta*2
	global_position = current_position.lerp(new_position, t)
	if global_position.distance_to(new_position) < 0.1:
		t=0.0
		current_position = new_position
		player.is_active = true
