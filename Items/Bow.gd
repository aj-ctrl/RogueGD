extends Node2D

export (PackedScene) var Projectile

export var fire_rate : float = 5
onready var update_delta : float = 1 / fire_rate
var current_time : float = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	look_at(get_global_mouse_position())
	
	current_time += delta
	if (current_time < update_delta):
		return
	
	if Input.is_action_pressed("attack"):
		current_time = 0
		fire()

func fire():
	var p = Projectile.instance()
	get_parent().get_parent().add_child(p)
	p.transform = $Position2D.global_transform
	$AudioStreamPlayer2D.play()
