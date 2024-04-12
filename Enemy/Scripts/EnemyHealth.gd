extends Node3D

class_name EnemyHealth

@onready var animation_player: AnimationPlayer = $"../AnimationPlayer"
@export var max_health : int = 100

var current_health : int

func _ready() -> void:
	current_health = max_health
	pass
	

func die():
	get_parent().queue_free()
	
func lose_health(amount):
	if current_health-amount > 0:
		current_health -= amount
		get_parent().trigger()
		animation_player.play("TakeDamage")
	else:
		current_health = 0
		die()
