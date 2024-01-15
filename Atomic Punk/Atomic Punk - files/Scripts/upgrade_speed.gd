extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false
	pass # Replace with function body.


func _on_area_entered(area):
	if area.is_in_group("hurtbox"):
		Globals.player_speed += 40
		print(Globals.player_speed)
		queue_free()


func _on_area_exited(area):
	if area.is_in_group("block"):
		await get_tree().create_timer(1.5).timeout
		visible = true
	pass # Replace with function body.
