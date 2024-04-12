extends Node3D

@onready var label_health: Label3D = $LabelHealth

@export var enemy : Enemy

func _process(delta) -> void:
	label_health.text = "HP: "+str(round(enemy.enemy_health.current_health))
		
