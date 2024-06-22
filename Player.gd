extends CharacterBody2D
class_name Player

@export var speed = 100
@export var rotation_speed = 1

var screen_size
var rotation_direction = 0

func _ready():
	screen_size = get_viewport_rect().size

func get_input():
	rotation_direction = Input.get_axis("left", "right")
	velocity = transform.x * Input.get_axis("down", "up") * speed

func _physics_process(delta):
	get_input()
	rotation += rotation_direction * rotation_speed * delta
	move_and_slide()
