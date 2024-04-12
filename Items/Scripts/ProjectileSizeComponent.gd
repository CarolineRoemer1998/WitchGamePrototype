extends Node3D

# projectile size increase by percentage %
@export var projectile_size := 0.25

func _on_item_projectile_size_body_entered(body: Player) -> void:
	body.attack_component.projectile_size += projectile_size
	print("Projectile Size: ", body.attack_component.projectile_size)
	get_parent().queue_free()
