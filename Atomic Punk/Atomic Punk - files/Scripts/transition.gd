extends CanvasLayer
@onready var color_react = $color_react

func change_scene(path, delay=2.5):
	var scene_transition = get_tree().create_tween()
	scene_transition.tween_property(color_react, "threshold", 1.0, 0.5)
	await scene_transition.finished
	assert(get_tree().change_scene_to_file(path) == OK)
