extends Area2D


export var velocity = 400

func _physics_process(delta):
	position += transform.x * velocity * delta


func _on_Projectile_body_entered(body):
	if body.name != "Player":
		if body.is_in_group("mobs"):
			$AudioStreamPlayer2D.play()
			body.queue_free()
		if !body.is_in_group("mobs"):
			queue_free()


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
