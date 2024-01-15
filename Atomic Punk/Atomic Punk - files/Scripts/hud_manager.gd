extends Control
@onready var score_counter = $container/score_container/score_counter as Label
@onready var life_counter = $container/life_container/life_counter as Label

# Called when the node enters the scene tree for the first time.
func _ready():
	score_counter.text = str("%04d" %Globals.score)
	life_counter.text = str("%01d" %Globals.player_life)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	score_counter.text = str("%04d" %Globals.score)
	life_counter.text = str("%01d" %Globals.player_life)
	pass
