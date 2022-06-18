extends KinematicBody2D

signal hit

export (PackedScene) var Bow

export var speed = 200 # pixels/sec the player will move
var screen_size
var is_weapon_equip = false

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
	
	if Input.is_action_just_pressed("interact"):
		equipWep()
	
	move_and_slide((velocity.normalized() * speed), Vector2.ZERO)
	
	if velocity != Vector2.ZERO:
		$Sprite/AnimationPlayer.play("Walk")
	else:
		$Sprite/AnimationPlayer.stop()


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

func equipWep():
	if is_weapon_equip == false:
		var weapon = Bow.instance()
		add_child(weapon)
		is_weapon_equip = true
