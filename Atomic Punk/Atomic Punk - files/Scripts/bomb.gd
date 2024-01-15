extends StaticBody2D
@onready var animation := $animation as AnimatedSprite2D
@onready var explosion_scene: PackedScene = preload(EXPLOSION_PATH)
@onready var explosion_spawn := $explosion_spawn as Marker2D
const EXPLOSION_PATH := "res://Atomic Punk - files/Scenes/explosion.tscn"
var bomb_explosion = false
var bomb_number = 0

enum CellType {
	EMPTY,
	WALL,
	BOMB_SPACE,
	POWER_UP
}
var map_width = 25
var map_height = 14
var tile_size = 48 
var mapa = []
var player_position = position
var map_cell_x = int(player_position.x / tile_size) - 1
var map_cell_y = int(player_position.y / tile_size) - 1
var explosion_positions = [
		Vector2(0, 0),
		Vector2(0, -1),
		Vector2(0, 1),
		Vector2(-1, 0),
		Vector2(1, 0) 
	]

# faça com que não seja possivel colocar uma bomba uma em cima da outra
func _ready():
	if(!Globals.bomb_time):
		await get_tree().create_timer(3).timeout
		var explosion_instance = explosion_scene.instantiate()
		get_parent().add_child(explosion_instance)
		explosion_instance.position = explosion_spawn.global_position
		queue_free()
	pass

func _process(delta):
	if(!Globals.bomb_time):
		animation.play("explosion")
	elif (Globals.bomb_time and !bomb_explosion):
		animation.play("idle")
	if(Globals.bomb_time and Input.is_action_just_pressed("EXPLODE")):
		Globals.bomb_number = 0
		_explode()
	pass

func _explode():
	bomb_explosion = true
	animation.play("explosion_idle")
	await get_tree().create_timer(1).timeout
	var explosion_instance = explosion_scene.instantiate()
	get_parent().add_child(explosion_instance)
	explosion_instance.position = explosion_spawn.global_position
	bomb_explosion = false
	queue_free()
