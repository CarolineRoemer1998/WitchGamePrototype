extends CharacterBody3D

class_name Player

@onready var pivot: Node3D = $Pivot
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var health_component: Node3D = $HealthComponent
@onready var attack_component: Node3D = $AttackComponent
@onready var block_component: Block = $Pivot/BlockComponent
@onready var dmg_box: Area3D = $DmgBox
@onready var timer_load_player: Timer = $TimerLoadPlayer

var speed_walking = 7.0
var speed_running = 12.0
const JUMP_VELOCITY = 8.5

var is_walking: bool = false
var is_running: bool = false
var is_blocking: bool = false
var jump_height: float = 3.0

var is_active = true

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")


func _ready() -> void:
	block_component.owner_type="Player"
	# Set Layer to PlayerDmgBox
	dmg_box.set_collision_layer_value(12,true)
	dmg_box.set_collision_layer_value(11,false)
	# Set Mask to EnemyAttack
	dmg_box.set_collision_mask_value(7,true)
	dmg_box.set_collision_mask_value(8,false)


func _physics_process(delta: float) -> void:
	if is_active:
		var input_dir := Input.get_vector("left", "right", "up", "down")
		add_gravity(delta)
		if GameStates.player_movement_enabled:
			handle_jump()
			handle_block()
			handle_movement(input_dir)
			rotate_and_move(input_dir)
			handle_animations()
		move_and_slide()


func handle_animations():
	if GameStates.player_movement_enabled:
		if is_walking and is_on_floor():
			animation_player.play("walk")
		elif is_running and is_on_floor():
			animation_player.play("run")
		elif is_on_floor():
			animation_player.play("idle")
		else:
			animation_player.play("RESET")
	else:
		animation_player.play("RESET")


func add_gravity(delta:float):
	if not is_on_floor():
		velocity.y -= gravity * delta * 2


func handle_jump():
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = sqrt(jump_height*2.0*gravity)


func handle_block():
	if Input.is_action_just_pressed("block"):
		block_component.visible = true
		for child in block_component.get_children():
			if child is CollisionShape3D:
				child.disabled = false
		is_blocking = true
	elif Input.is_action_just_released("block"):
		block_component.visible = false
		for child in block_component.get_children():
			if child is CollisionShape3D:
				child.disabled = true
		is_blocking = false


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
	if (is_walking or is_running):
		pivot.look_at(position + Vector3(input_dir.x, 0, input_dir.y), Vector3.UP)


func _on_timer_load_player_timeout() -> void:
	if GameStates.player_location == "Forest":
		GameStates.player_movement_enabled = false
		velocity = Vector3.ZERO


func _on_timer_enable_movement_timeout() -> void:
	if GameStates.player_location == "Forest":
		GameStates.player_movement_enabled = true
