extends Node2D
@onready var player = $Player

enum CellType {
	EMPTY,
	WALL,
	BOMB_SPACE,
	POWER_UP
}

# Tamanho do mapa (número de linhas e colunas)
var map_width = 24
var map_height = 13

# Crie a matriz que representará o mapa
var mapa = []

# Called when the node enters the scene tree for the first time.
func _ready():
	# Inicialize o mapa como uma grade vazia (células vazias)
	for x in range(map_width):
		mapa.append([])
		for y in range(map_height):
			# Defina o tipo de célula padrão como vazio (EMPTY)
			mapa[x].append(CellType.EMPTY)
	
	mapa[0][1] = CellType.WALL
	
	player.player_has_died.connect(reload_game)
	Globals.player_life = 5
	Globals.score = 0
	pass # Replace with function body.
	

func _process(delta):
	pass
	
func get_cell_type(x, y):
	return mapa[x][y]

func set_cell_type(x, y, cell_type):
	mapa[x][y] = cell_type

func reload_game():
	await get_tree().create_timer(1).timeout
	get_tree().reload_current_scene()
