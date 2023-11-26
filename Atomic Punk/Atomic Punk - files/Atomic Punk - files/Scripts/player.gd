extends CharacterBody2D

@onready var bomb_scene: PackedScene = preload(BOMB_PATH)
@onready var animation := $animation as AnimatedSprite2D
@onready var timer := $Timer as Timer
@onready var bomb_spawn := $bomb_spawn as Marker2D
const BOMB_PATH := "res://Atomic Punk - files/Scenes/bomb.tscn"
const SPEED = 200

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

func _ready():
	for x in range(map_width):
		mapa.append([])
		for y in range(map_height):
			# Defina o tipo de célula padrão como vazio (EMPTY)
			mapa[x].append(CellType.EMPTY)
	pass

func _process(delta):
	var direction_x = Input.get_axis("ui_left", "ui_right")
	var direction_y = Input.get_axis("ui_up", "ui_down")
	if direction_x:
		velocity.x = direction_x * SPEED
		animation.play("run-right")
		animation.scale.x = direction_x
	else:
		velocity.x = 0
		if !direction_y:
			animation.play("idle-right")
		
	if direction_y:
		velocity.y = direction_y * SPEED 
		if Input.is_action_just_pressed("ui_up"):
			animation.play("run-up")
		if Input.is_action_just_pressed("ui_down"):
			animation.play("run-down")
	else:
		velocity.y = 0
	
	if Input.is_action_just_pressed("SPAWN_BOMB"):
		var player_position = position
		var map_cell_x = int(player_position.x / tile_size) - 1
		var map_cell_y = int(player_position.y / tile_size) - 1
		if colocar_bomba_na_posicao(map_cell_x, map_cell_y):
			print(map_cell_x, " x ", map_cell_y, " - ", get_cell_type(map_cell_x, map_cell_y))
			var bomb_instance = bomb_scene.instantiate()
			get_parent().add_child(bomb_instance)
			bomb_instance.position = bomb_spawn.global_position
		else:
			if !_on_timer_timeout():
				print(get_cell_type(map_cell_x, map_cell_y))
				mapa[map_cell_x][map_cell_y] = CellType.EMPTY
			
	move_and_slide()

func set_cell_type(x, y, cell_type):
	mapa[x][y] = cell_type

func get_cell_type(x, y):
	return mapa[x][y]

func _on_timer_timeout():
	timer.start()
	return timer

func colocar_bomba_na_posicao(pos_x, pos_y):
	if mapa[pos_x][pos_y] == CellType.EMPTY:
		mapa[pos_x][pos_y] = CellType.BOMB_SPACE
		return true
	if mapa[pos_x][pos_y] == CellType.BOMB_SPACE:
		return false
# faça com que não seja possivel colocar uma bomba uma em cima da outra 
