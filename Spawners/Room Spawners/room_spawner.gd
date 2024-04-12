extends Area3D

class_name RoomSpawner

# -------------------------------------------------------------------------
# variables
# -------------------------------------------------------------------------

@export var room : PackedScene
@onready var spawner_center : Node3D = get_parent()
@onready var camera : Camera3D = get_tree().get_first_node_in_group("camera")

var room_parent : Node3D
var room_spawn_position : Vector3
var is_triggered = false
var new_camera_position : Vector3

# -------------------------------------------------------------------------
# functions
# -------------------------------------------------------------------------

func _on_body_entered(body: Node3D) -> void:
	set_room_parent()
	set_room_spawn_position()
	var new_room = spawn_room()
	set_camera_positions(new_room)
	set_active_and_last_room(new_room)
	despawn_rooms()

## Sets the node where the room should be spawned in as a child
## Returns true if successful, false if not
func set_room_parent() -> bool:
	if get_parent().get_parent().name == "Rooms":
		room_parent = get_parent().get_parent()
		return true
	return false

## Sets the position the room should spawn at when spawner body is entered
## Returns true if successful, false if not
func set_room_spawn_position() -> bool:
	var was_successful = false
	for child in get_children():
		if child.name == "RoomSpawn":
			room_spawn_position = child.global_position
			spawner_center.global_position = room_spawn_position
			was_successful = true
	return was_successful

## Instantiates new Room and sets its position to room_spawn_position
## Returns the new Room
func spawn_room() -> NavigationRegion3D:
	var new_room = room.instantiate()
	room_parent.add_child(new_room)
	new_room.global_position = room_spawn_position
	return new_room

## Sets the the new Camera Position to the center of the new Room
func set_camera_positions(new_room : NavigationRegion3D):
	new_camera_position = new_room.get_child(0).global_position
	camera.new_position = new_camera_position

## Changes current Room Group from "active" to "last_room" 
## Adds the new room to group "active"
## Deletes groups from all other rooms
func set_active_and_last_room(new_room : NavigationRegion3D):
	for child in get_parent().get_parent().get_children():
		if child.is_in_group("active"):
			child.remove_from_group("active")
			child.add_to_group("last_room")
		elif child.is_in_group("last_room"):
			child.remove_from_group("last_room")
	new_room.add_to_group("active")

## queue_free() on all rooms that are not in groups "active" or "last_room"
func despawn_rooms():
	for child in get_parent().get_parent().get_children():
		if child is NavigationRegion3D:
			if !child.is_in_group("active") and !child.is_in_group("last_room"):
				child.queue_free()
