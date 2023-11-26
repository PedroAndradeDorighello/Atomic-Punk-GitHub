extends Node2D

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
	exemplo_de_uso()
	pass # Replace with function body.
	

func _process(delta):
	pass
	
func get_cell_type(x, y):
	return mapa[x][y]

func set_cell_type(x, y, cell_type):
	mapa[x][y] = cell_type

func exemplo_de_uso():
	# Verificando o tipo de célula em uma posição específica
	var tipo_celula = get_cell_type(0, 1)
	print(tipo_celula)  # Deve imprimir "Tipo de célula em (2, 2): WALL"

	# Definindo uma célula como espaço para bomba
	set_cell_type(3, 3, CellType.BOMB_SPACE)
