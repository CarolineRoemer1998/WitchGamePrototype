extends Area3D

var direction : Vector3 = Vector3.FORWARD
var speed : float = 15

func _physics_process(delta: float) -> void:
	position += direction*delta*speed


func _on_timer_despawn_timeout() -> void:
	queue_free()


func _on_body_entered(body: Node3D) -> void:
	if body is Enemy:
		body.enemy_health.lose_health(get_parent().strength)
		queue_free()
