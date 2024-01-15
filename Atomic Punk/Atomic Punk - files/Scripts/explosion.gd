extends Area2D
@onready var main_light = $main_light
@onready var animation := $animation as AnimatedSprite2D
@onready var animation1_1 := %animation1_1 as AnimatedSprite2D
@onready var animation1_2 := %animation1_2 as AnimatedSprite2D
@onready var animation2_1 := %animation2_1 as AnimatedSprite2D
@onready var animation2_2 := %animation2_2 as AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	main_light.visible = false
	animation.play("explosion")
	animation1_1.play("explosion")
	animation1_2.play("explosion")
	animation2_1.play("explosion")
	animation2_2.play("explosion")
	await get_tree().create_timer(1.5).timeout 
	_on_timer_timeout()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if get_tree().current_scene.name == "World-02":
		main_light.visible = true

func _on_timer_timeout():
	queue_free() 
