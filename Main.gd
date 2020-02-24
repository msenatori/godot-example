extends Node2D


export (PackedScene) var Mob
var score

func _ready():
	randomize()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()

func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	$StartTimer.start()


func _on_MobTimer_timeout():
	$MobPath/PathFollow2D.set_offset(randi());
	
	var mob = Mob.instance()
	
	$HUD.connect("start_game", mob, "_on_start_game")
	
	add_child(mob)
	# Set the mob's direction perpendicular to the path direction.
	var direction = $MobPath/PathFollow2D.rotation + PI / 2
	 # Set the mob's position to a random location.
	mob.position = $MobPath/PathFollow2D.position
	# Add some randomness to the direction.
	direction += rand_range(-PI / 4, PI / 4)
	mob.rotation = direction
	# Set the velocity (speed & direction).
	mob.linear_velocity = Vector2(rand_range(mob.min_speed, mob.max_speed), 0)
	mob.linear_velocity = mob.linear_velocity.rotated(direction)


func _on_ScoreTimer_timeout():
	score += 1
	$HUD.update_score(score)


func _on_StartTimer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()
