extends KinematicBody2D

export var speed = 100

var player

func _ready():
	player = get_node("../Player")

func _physics_process(delta):
	if not player:
		return
	var dir = (player.global_position - global_position).normalized()
	move_and_collide(dir * speed * delta)

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
