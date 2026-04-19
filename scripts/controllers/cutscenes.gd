extends CanvasLayer
var current_panel := 0
var panels = []
var next_scene_name : String

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	get_tree().paused = true
	panels = [$Main_01, $Main_02, $Main_03, $Main_04]
	show_only(0)

func _input(event):
	if event.is_action_pressed("next") and not event.is_echo():
		current_panel += 1
		if current_panel < panels.size():
			show_only(current_panel)
		else:
			if next_scene_name != "":
				get_tree().paused = false
				var sunny = get_tree().root.get_node("Sunny")
				if sunny.current_level:
					sunny.current_level.queue_free()
				var next_level = Scene_Manager.load_scene(next_scene_name)
				await get_tree().process_frame
				sunny.reset_for_new_level(next_level)
				queue_free()
			else:
				print("No next scene assigned")

func show_only(index):
	for i in range(panels.size()):
		panels[i].visible = (i == index)
