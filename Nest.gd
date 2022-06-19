extends StaticBody2D


export (PackedScene) var mob_scene

func _ready():
	var game_start = get_parent()
	game_start.connect("game_start", self, "_on_game_start")


func _on_MobTimer_timeout():
	# create new mob instance
	var mob = mob_scene.instance()
	
	mob.position = self.position
	
	# spawn the mob
	owner.add_child(mob)

func _on_game_start():
	$MobTimer.start()
