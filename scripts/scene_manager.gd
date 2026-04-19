extends Node
const SCENES = {
	"level_1": preload("uid://3d745ff2p7wp"),
	"level_2": preload("uid://spyj3w6vigxf")
}
func load_scene(scene_name: String) -> Node:
	if SCENES.has(scene_name):
		var scene_instance = SCENES[scene_name].instantiate()
		get_tree().root.call_deferred("add_child", scene_instance)
		return scene_instance
	else:
		print("Scene not found: ", scene_name)
		return null
