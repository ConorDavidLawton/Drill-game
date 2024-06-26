extends CharacterBody2D
class_name Player

@export var speed = 50
@export var rotation_speed = 0.6

var rotation_direction = 0
var object_hit

func drill():
	if object_hit.is_in_group("Destructibles"):
		object_hit.get_parent().clip($"DestructionArea/DestructionPoly")

func get_input():
	rotation_direction = Input.get_axis("left", "right")
	velocity = transform.x * Input.get_axis("down", "up") * speed

func _physics_process(delta):
	get_input()
	rotation += rotation_direction * rotation_speed * delta
	move_and_slide()

func _on_drill_detection_body_entered(body: Node) -> void:
	if body.is_in_group("Player"): return
	object_hit = body
	drill()
