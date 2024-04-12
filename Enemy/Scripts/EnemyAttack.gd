extends Node3D

@onready var timer_cooldown: Timer = $TimerCooldown

@export var strength := 20
@export var cool_down := 1.0
@export var projectile : PackedScene
@export var projectile_speed := 15
@export var projectile_size := 1.0

@export var is_triggered := false

var new_projectile

func _ready() -> void:
	timer_cooldown.wait_time = cool_down

func _on_timer_cooldown_timeout() -> void:
	if is_triggered:
		new_projectile = projectile.instantiate()
		get_tree().root.add_child(new_projectile)
		new_projectile.global_position = get_parent().global_position
		new_projectile.scale *= projectile_size
		new_projectile.speed = projectile_speed
		new_projectile.strength = strength
	timer_cooldown.start()
