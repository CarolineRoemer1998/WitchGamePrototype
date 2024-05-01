extends Node3D

class_name Projectile4Ways

@onready var shot_1: Area3D = $Shot1
@onready var shot_2: Area3D = $Shot2
@onready var shot_3: Area3D = $Shot3
@onready var shot_4: Area3D = $Shot4

@export var speed := 15
@export var strength := 20

func _on_timer_despawn_timeout() -> void:
	queue_free()

func _physics_process(delta: float) -> void:
	if shot_1 != null:
		shot_1.global_position += Vector3(0,0,-1)*delta*speed
	if shot_2 != null:
		shot_2.global_position += Vector3(0,0,1)*delta*speed
	if shot_3 != null:
		shot_3.global_position += Vector3(-1,0,0)*delta*speed
	if shot_4 != null:
		shot_4.global_position += Vector3(1,0,0)*delta*speed


func deal_damage(body: Node3D, projectile: Area3D):
	if body is Player:
		body.health_component.lose_health(strength)
		projectile.queue_free()
	elif not body is Enemy: 
		projectile.queue_free()
		
func destroy_self(area: Area3D, projectile: Area3D):
	if area is Block:
		projectile.queue_free()

func _on_shot_1_body_entered(body: Node3D) -> void:
	deal_damage(body, shot_1)


func _on_shot_2_body_entered(body: Node3D) -> void:
	deal_damage(body, shot_2)


func _on_shot_3_body_entered(body: Node3D) -> void:
	deal_damage(body, shot_3)


func _on_shot_4_body_entered(body: Node3D) -> void:
	deal_damage(body, shot_4)


func _on_shot_1_area_entered(area: Area3D) -> void:
	destroy_self(area, shot_1)


func _on_shot_2_area_entered(area: Area3D) -> void:
	destroy_self(area, shot_2)


func _on_shot_3_area_entered(area: Area3D) -> void:
	destroy_self(area, shot_3)


func _on_shot_4_area_entered(area: Area3D) -> void:
	destroy_self(area, shot_4)
