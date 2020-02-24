extends RigidBody2D

export var min_speed = 150
export var max_speed = 250
var mob_types = ["walk", "swin", "fly"]
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.animation = mob_types[randi() % mob_types.size()]

func _on_Visibility_screen_exited():
	queue_free()

func _on_start_game():
	queue_free()