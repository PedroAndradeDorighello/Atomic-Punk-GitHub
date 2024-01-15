extends CharacterBody2D

@onready var animation := $animation as AnimatedSprite2D
@onready var wall_detector := $wall_detector as RayCast2D
@onready var wall_detector2 := $wall_detector2 as RayCast2D
@onready var wall_detector3 := $wall_detector3 as RayCast2D
const SPEED = 160

var score := 10
var direction := 1 


func _process(delta):
	velocity.x = direction * SPEED
	animation.play("walk")
	
	if wall_detector.is_colliding() or wall_detector2.is_colliding() or wall_detector3.is_colliding():
		direction *= -1
		wall_detector.scale.x *= -1
		wall_detector2.scale.x *= -1
		wall_detector3.scale.x *= -1

	if direction == -1:
		animation.flip_h = true
	else:
		animation.flip_h = false
	
	
	move_and_slide()


func _on_hitbox_area_entered(area):
	if	area.name == "explosion" or area.is_in_group("explosion"):
		Globals.score += score
		print(Globals.score)
		queue_free()
	pass # Replace with function body.
