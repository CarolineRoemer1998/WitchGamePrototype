extends Node3D

@export var cooldown_multiplier = 0.8

func _on_item_projectile_cooldown_body_entered(body: Player) -> void:
	body.attack_component.cool_down *= cooldown_multiplier
	print("Shot Cooldown Time: ", body.attack_component.cool_down)
	get_parent().queue_free()
