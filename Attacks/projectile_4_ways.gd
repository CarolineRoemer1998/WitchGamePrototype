extends Node3D

class_name Projectile4Ways

@export var shot: PackedScene

@export var speed := 15.0
@export var strength := 20.0


func _ready() -> void:
	var shot_1 = shot.instantiate()
	set_projectile_properties(shot_1,Vector3(0,0,-1))
#	shot_1.
	add_child(shot_1)
	
	var shot_2 = shot.instantiate()
	set_projectile_properties(shot_2,Vector3(0,0,1))
	add_child(shot_2)
	
	var shot_3 = shot.instantiate()
	set_projectile_properties(shot_3,Vector3(-1,0,0))
	add_child(shot_3)
	
	var shot_4 = shot.instantiate()
	set_projectile_properties(shot_4,Vector3(1,0,0))
	add_child(shot_4)


func set_projectile_properties(_shot, direction):
	_shot.speed = speed
	_shot.strength = strength
	_shot.direction = direction
	_shot.source_type = "Enemy"


func _on_timer_despawn_timeout() -> void:
	queue_free()
