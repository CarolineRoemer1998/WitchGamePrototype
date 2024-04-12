extends Area3D

@onready var camera_spot: Node3D = $"../CameraSpot"

var old_position : Vector3 
var new_position : Vector3 

var camera : Camera3D
var is_sliding = false
#var first_position : Vector3 = Vector3(0, 35, 20)
#var new_position : Vector3 
var t = 0.0

func _ready() -> void:
	camera = get_tree().get_first_node_in_group("camera")
	old_position = camera.get_parent().global_position
	new_position = camera_spot.global_position
	
func _physics_process(delta: float) -> void:
	move_camera(delta)

func move_camera(delta: float):
	if is_sliding:
		t += delta*2
		camera.global_position = old_position.lerp(new_position, t)
		if camera.global_position.distance_to(new_position) < 0.1:
			queue_free()

func _on_body_entered(body: Node3D) -> void:
	camera.reparent(camera_spot,true)
	is_sliding = true
