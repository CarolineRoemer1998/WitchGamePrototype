extends CharacterBody3D

class_name Player

@onready var pivot: Node3D = $Pivot
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var health_component: Node3D = $HealthComponent
@onready var attack_component: Node3D = $AttackComponent
@export var click_manager: PackedScene

var speed_walking = 7.0
var speed_running = 12.0
const JUMP_VELOCITY = 8.5

var is_walking: bool = false
var is_running: bool = false
var jump_height: float = 3.0

var is_active = true

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

func _physics_process(delta: float) -> void:
	if is_active:
		var input_dir := Input.get_vector("left", "right", "up", "down")
		add_gravity(delta)
		handle_jump()
		handle_movement(input_dir)
		rotate_and_move(input_dir)
		handle_animations()

func handle_animations():
	if is_walking and is_on_floor():
		animation_player.play("walk")
	elif is_running and is_on_floor():
		animation_player.play("run")
	elif is_on_floor():
		animation_player.play("idle")
	else:
		animation_player.play("RESET")

func add_gravity(delta:float):
	if not is_on_floor():
		velocity.y -= gravity * delta * 2


func handle_jump():
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = sqrt(jump_height*2.0*gravity)


func handle_movement(input_dir):
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		if Input.is_action_pressed("running"):
			is_walking = false
			is_running = true
			velocity.x = direction.x * speed_running
			velocity.z = direction.z * speed_running
		else:
			is_running = false
			is_walking = true
			velocity.x = direction.x * speed_walking
			velocity.z = direction.z * speed_walking
		
	else:
		is_running = false
		is_walking = false
		velocity.x = move_toward(velocity.x, 0, speed_walking)
		velocity.z = move_toward(velocity.z, 0, speed_walking)


func rotate_and_move(input_dir):
	if is_walking or is_running:
		pivot.look_at(position + Vector3(input_dir.x, 0, input_dir.y), Vector3.UP)
	move_and_slide()
