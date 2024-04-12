extends Node3D

class_name Attack

@onready var timer_cooldown: Timer = $TimerCooldown

@export var strength := 20
@export var cool_down := 1.0
@export var projectile : PackedScene
@export var projectile_speed := 15
@export var projectile_size := 1.0

var is_cooling_down = false

func _ready() -> void:
	timer_cooldown.wait_time = cool_down
	
func _physics_process(delta: float) -> void:
	handle_shooting()
	if timer_cooldown.wait_time != cool_down:
		timer_cooldown.wait_time = cool_down
		

func attack(opponent : Health):
	opponent.lose_health(strength)

func shoot(target_position : Vector3):
	if not is_cooling_down:
		var new_projectile = projectile.instantiate()
		add_child(new_projectile)
		set_projectile_properties(new_projectile, target_position)
		
		timer_cooldown.start()
		is_cooling_down = true

func _on_timer_cooldown_timeout() -> void:
	is_cooling_down = false
	
func set_projectile_properties(_projectile: Area3D, target_position: Vector3):
	var starting_position = get_parent().global_position
	_projectile.global_position = Vector3(starting_position.x,1,starting_position.z)
	_projectile.direction = target_position
	_projectile.speed = projectile_speed
	_projectile.scale *= projectile_size
	
func handle_shooting():
	var target
	
	if Input.is_action_pressed("ui_up"):
		target = Vector3(0,0,-1)
	elif Input.is_action_pressed("ui_down"):
		target = Vector3(0,0,1)
	elif Input.is_action_pressed("ui_left"):
		target = Vector3(-1,0,0)
	elif Input.is_action_pressed("ui_right"):
		target = Vector3(1,0,0)
		
	if target:
		shoot(target)
