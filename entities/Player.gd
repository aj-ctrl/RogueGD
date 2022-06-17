extends KinematicBody2D

signal hit

export var speed = 200 # pixels/sec the player will move
var screen_size

func _ready():
	screen_size = get_viewport_rect().size

func _process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	
	move_and_slide((velocity.normalized() * speed), Vector2.ZERO)


func _on_Area2D_body_entered(body):
	if body.is_in_group("mobs"):
		hide() # hides player on hit
		emit_signal("hit")
		$Area2D/CollisionShape2D.set_deferred("disabled", true)
	else:
		pass
	

func start(pos):
	position = pos
	show()
	$Area2D/CollisionShape2D.disabled = false
