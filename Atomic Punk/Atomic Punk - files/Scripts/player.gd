extends CharacterBody2D
@onready var bomb_scene: PackedScene = preload(BOMB_PATH)
@onready var animation := $animation as AnimatedSprite2D
@onready var timer := $Timer as Timer
@onready var bomb_spawn := $bomb_spawn as Marker2D
@onready var hurtbox := $hurtbox as Area2D
@onready var collision_hurtbox = $hurtbox/collision_hurtbox
const BOMB_PATH := "res://Atomic Punk - files/Scenes/bomb.tscn"
var player_position
var direction_x
var direction_y
var is_hurted = false
signal player_has_died

enum CellType {
	EMPTY,
	WALL,
	BOMB_SPACE,
	POWER_UP
}
var map_cell_x
var map_cell_y
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
	direction_x = Input.get_axis("ui_left", "ui_right")
	direction_y = Input.get_axis("ui_up", "ui_down")
	if get_tree().current_scene.name == "World-02":
		Globals.startPosition = Vector2(1128, 440)
	if direction_x and !is_hurted:
		velocity.x = direction_x * Globals.player_speed
	else:
		velocity.x = 0
		
	if direction_y and !is_hurted:
		velocity.y = direction_y * Globals.player_speed 
	else:
		velocity.y = 0
	
	if Globals.bomb_time:
		if Input.is_action_just_pressed("SPAWN_BOMB") and Globals.bomb_number < 5 and !is_hurted:
				spawn_bomb()
	else:
		if Input.is_action_just_pressed("SPAWN_BOMB") and !is_hurted:
			spawn_bomb()
			
	_set_state()
	move_and_slide()

func spawn_bomb():
	player_position = position
	map_cell_x = int(player_position.x / tile_size) - 1
	map_cell_y = int(player_position.y / tile_size) - 1
	print("(", map_cell_x, " ; ", map_cell_y, ") = ", get_cell_type(map_cell_x, map_cell_y))
	if !get_cell_type(map_cell_x, map_cell_y):
		if Globals.bomb_time:
			Globals.bomb_number += 1
		position_the_bomb(map_cell_x, map_cell_y)
		var bomb_instance = bomb_scene.instantiate()
		get_parent().add_child(bomb_instance)
		bomb_instance.position = bomb_spawn.global_position
	
func set_cell_type(x, y, cell_type):
	mapa[x][y] = cell_type

func get_cell_type(x, y):
	return mapa[x][y]

func position_the_bomb(pos_x, pos_y):
	if mapa[pos_x][pos_y] == CellType.EMPTY:
		mapa[pos_x][pos_y] = CellType.BOMB_SPACE
		await get_tree().create_timer(4).timeout
		mapa[pos_x][pos_y] = CellType.EMPTY

func _on_hurtbox_body_entered(body):
	if body.is_in_group("enemies"):
		take_damage()
		
func _on_hurtbox_area_entered(area):
	if area.is_in_group("explosion") or area.name == "hitbox":
		take_damage()

func take_damage():
	Globals.player_life -= 1
	is_hurted = true
	await get_tree().create_timer(1).timeout
	if Globals.player_life <= 0:
		print("dead")
		queue_free()
		emit_signal("player_has_died")
	else:
		await get_tree().create_timer(0.5).timeout
		is_hurted = false
		position = Globals.startPosition
		print(Globals.player_life)

func _set_state():
	var state = "idle-right"
	
	if is_hurted:
		animation.play("damege")
		collision_hurtbox.set_disabled(true)
	else:
		collision_hurtbox.set_disabled(false)
		if direction_x and !direction_y:
			animation.play("run-right")
			animation.scale.x = direction_x
		elif !direction_x and !direction_y:
			animation.play("idle-right")
		elif direction_y:
			if Input.is_action_just_pressed("ui_up"):
				animation.play("run-up")
			if Input.is_action_just_pressed("ui_down"):
				animation.play("run-down")
