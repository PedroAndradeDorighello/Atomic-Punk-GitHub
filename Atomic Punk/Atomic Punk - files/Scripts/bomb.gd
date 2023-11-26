extends StaticBody2D
@onready var animation := $animation as AnimatedSprite2D
@onready var timer := $Timer as Timer
signal bomb_available
signal bomb_unavailable
var bomb_release = true
# faça com que não seja possivel colocar uma bomba uma em cima da outra
func _ready():
	timer.start()
	pass

func _process(delta):
	animation.play("explosion")
	pass

func _on_timer_timeout():
	queue_free() 


func _on_body_entered(body):
	pass 


func _on_body_exited(body):
	pass 
