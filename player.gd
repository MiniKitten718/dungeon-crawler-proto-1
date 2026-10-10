extends Node3D

var grid_position: Vector3i = Vector3i(0, 0, 0)
const NORTH = Vector3i(0, 0, -1)
const SOUTH = Vector3i(0, 0, 1)
const EAST = Vector3i(1, 0, 0)
const WEST = Vector3i(-1, 0, 0)
var facing: int = 0
const FORWARD = 0
const RIGHT = 1
const BACKWARD = 2
const LEFT = 3


@onready var dungeon = $"../Dungeon"





func update_world_position():
	position = dungeon.to_global(dungeon.map_to_local(grid_position))


func _ready():
	update_world_position()
	print("A")


func move_relative(direction):
	var world_direction

	match facing:
		0:
			world_direction = [NORTH, EAST, SOUTH, WEST][direction]
		90:
			world_direction = [EAST, SOUTH, WEST, NORTH][direction]
		180:
			world_direction = [SOUTH, WEST, NORTH, EAST][direction]
		270:
			world_direction = [WEST, NORTH, EAST, SOUTH][direction]
	move_world(world_direction)


func move_world(direction):
	grid_position += direction
	update_world_position()


func turn_left():
	facing -= 90
	if facing < 0:
		facing += 360
	rotation.y = deg_to_rad(-facing)

func turn_right():
	facing += 90
	if facing >= 360:
		facing -= 360
	rotation.y = deg_to_rad(-facing)


func _process(_delta):
	if Input.is_action_just_pressed("move_forward"):
		move_relative(FORWARD)
	elif Input.is_action_just_pressed("move_backward"):
		move_relative(BACKWARD)
	elif Input.is_action_just_pressed("move_left"):
		move_relative(LEFT)
	elif Input.is_action_just_pressed("move_right"):
		move_relative(RIGHT)	
	elif Input.is_action_just_pressed("turn_left"):
		turn_left()
	elif Input.is_action_just_pressed("turn_right"):
		turn_right()
		
