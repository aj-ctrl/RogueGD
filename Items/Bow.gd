extends Node2D


export (PackedScene) var Projectile


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	look_at(get_global_mouse_position())
	
	if Input.is_action_pressed("attack"):
		fire()

func fire():
	var p = Projectile.instance()
	get_parent().get_parent().add_child(p)
	p.transform = $Position2D.global_transform
