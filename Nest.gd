extends StaticBody2D


export (PackedScene) var mob_scene

export var amount_to_spawn = 100

func _ready():
	var game_start = get_parent()
	game_start.connect("game_start", self, "_on_game_start")


func _on_MobTimer_timeout():
	if amount_to_spawn > 0:
		# create new mob instance
		var mob = mob_scene.instance()
		#set pos to nest
		mob.position = self.position
		# spawn the mob
		owner.add_child(mob)
		#incriment counter
		amount_to_spawn -= 1
	else:
		queue_free()

func _on_game_start():
	$MobTimer.start()
