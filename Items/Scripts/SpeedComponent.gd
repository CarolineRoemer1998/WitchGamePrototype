extends Node3D

@export var speed_boost = 20.0 # percentage

func _on_item_speed_body_entered(body: Player) -> void:
	body.speed_walking = body.speed_walking/100*(100+speed_boost)
	speed_boost -= speed_boost/2
	print("Shot Speed: ", body.attack_component.projectile_speed)
	get_parent().queue_free()
