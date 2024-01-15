extends Area2D
@onready var transition = $"../transition"
@export var next_level : String = ""

func _ready():
	visible = false

func _on_area_entered(area):
	if area.is_in_group("hurtbox") and !next_level == "":
		print("area complete!")
		transition.change_scene(next_level)
	if area.is_in_group("explosion"):
		await get_tree().create_timer(1.5).timeout
		visible = true
