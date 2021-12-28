extends Control

func _ready():
	#Make BG transparent
	get_tree().get_root().set_transparent_background(true)
	OS.window_borderless = true

func _on_Panel_mouse_entered():
	OS.window_borderless = false


func _on_Panel_mouse_exited():
	OS.window_borderless = true
