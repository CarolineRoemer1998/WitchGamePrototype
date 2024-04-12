extends Node3D

@onready var mesh_instance_3d: MeshInstance3D = $MeshInstance3D

@export var instances : Array[PackedScene]

var num_generator = RandomNumberGenerator.new()

func _ready() -> void:
	var rnd = num_generator.randi_range(0, instances.size()-1)
	var new_instance = instances[rnd].instantiate()
	add_child(new_instance)
	mesh_instance_3d.visible = false
