extends CharacterBody3D

class_name Enemy

@onready var navigation_agent_3d: NavigationAgent3D = $NavigationAgent3D
@onready var pivot: Node3D = $MeshPivot
@onready var enemy_health: Node3D = $EnemyHealth
@onready var enemy_attack: Node3D = $EnemyAttack

@export var aggro_range := 10.0
@export var is_triggered := false
var player

@export var SPEED = 3.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")

func _process(delta: float) -> void:
	navigation_agent_3d.target_position = player.global_position

func _physics_process(delta: float) -> void:
	var next_position = navigation_agent_3d.get_next_path_position()
	var direction = global_position.direction_to(next_position)
	var player_distance = global_position.distance_to(player.global_position)
	
	if player_distance <= aggro_range:
		is_triggered = true
		enemy_attack.is_triggered = true
		
	if is_triggered and player_distance >= 2.0:
		move_and_slide()
		handle_movement(direction)
		
	add_gravity(delta)
	
	

func add_gravity(delta:float):
	if not is_on_floor():
		velocity.y -= gravity * delta

func handle_movement(direction):
	if direction:
		look_at_target(direction)
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)


func look_at_target(_direction):
	var horizontal_direction = _direction
	horizontal_direction.y = 0
	look_at(global_position+horizontal_direction, Vector3.UP, true)
	
	
func trigger():
	is_triggered = true
	enemy_attack.is_triggered = true
