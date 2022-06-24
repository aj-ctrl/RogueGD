extends KinematicBody2D

signal hit

var bow = load("res://Items/Bow.tscn")

export var speed = 200 # pixels/sec the player will move
var is_alive = false

func _process(delta):
	#if the player is alive
	if is_alive:
		#allow player to move
		player_movement()
		#allow player to equip bow
		if Input.is_action_just_pressed("interact"):
			equip_weapon(bow)
	#if the player is NOT alive
	else:
		#remove player sprite
		self.hide()
		#delete bow to stop shooting
		if get_node("Bow"):
			$Bow.queue_free()


func player_movement():
	#get l/r/u/d movement and store it in velocity
	var mv_x = Input.get_action_strength("mv_right") - Input.get_action_strength("mv_left")
	var mv_y = Input.get_action_strength("mv_down") - Input.get_action_strength("mv_up")
	var velocity = Vector2(mv_x, mv_y)
	
	#apply movement
	move_and_slide((velocity.normalized() * speed), Vector2.ZERO)
	
	#walking animation when moving
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

func equip_weapon(weapon):
	add_child(bow.instance())
