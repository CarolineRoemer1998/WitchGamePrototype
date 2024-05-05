extends Area3D

class_name Block

var owner_type = "Player"

func _on_area_entered(area: Area3D) -> void:
	if area is Projectile:
		if owner_type == "Player" and area.source_type=="Enemy":
			area.queue_free()
