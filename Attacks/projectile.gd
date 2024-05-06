extends Area3D

class_name Projectile

@onready var mesh_instance_3d: MeshInstance3D = $MeshInstance3D

var red = preload("res://Fundamentals/World Design/Colors/enemy_attack.tres")

var direction : Vector3 = Vector3.FORWARD
var speed := 5.0
var strength := 20.0
var source_type := "Player"

func _ready():
	set_type()

func _physics_process(delta: float) -> void:
	position += direction*delta*speed

func set_type():
	set_collision_mask_value(4,true)
	
	if source_type == "Player":
		set_collision_layer_value(8,true)   # PlayerAttack
		set_collision_mask_value(9,true)    # EnemyBlock
		set_collision_mask_value(11,true)   # EnemyDmgBox
		set_collision_layer_value(7,false)
		set_collision_mask_value(10,false)
		set_collision_mask_value(12,false)
	if source_type == "Enemy":
		set_collision_layer_value(7,true)   # EnemyAttack
		set_collision_mask_value(10,true)   # PlayerBlock
		set_collision_mask_value(12,true)   # PlayerDmgBox
		set_collision_layer_value(8,false)
		set_collision_mask_value(9,false)        
		set_collision_mask_value(11,false)
		
		# Set Color of Enemy's Projectiles to Red
		mesh_instance_3d.material_override = red


func _on_timer_despawn_timeout() -> void:
	queue_free()


func _on_body_entered(body: Node3D) -> void:
	if body.get_collision_layer_value(4):
		queue_free()


func _on_area_entered(area: Area3D) -> void:
	if area.get_collision_layer_value(12) and area.get_parent() is Player:
		area.get_parent().health_component.lose_health(strength)
		queue_free()
	elif area.get_collision_layer_value(11) and area.get_parent() is Enemy:
		area.get_parent().enemy_health.lose_health(strength)
		queue_free()
		
