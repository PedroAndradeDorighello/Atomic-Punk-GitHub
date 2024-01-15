extends Area2D

@onready var explosion_scene: PackedScene = preload(EXPLOSION_PATH)
@onready var explosion_spawn := %explosion_spawn as Marker2D
const EXPLOSION_PATH := "res://Atomic Punk - files/Scenes/explosion.tscn"

func _on_area_2d_area_entered(area):
	if area.is_in_group("explosion"):
		var explosion_instance = explosion_scene.instantiate()
		get_parent().add_child(explosion_instance)
		explosion_instance.position = explosion_spawn.global_position
		queue_free()
	pass # Replace with function body.
