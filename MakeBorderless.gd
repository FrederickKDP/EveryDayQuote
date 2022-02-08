extends Control

onready var delay = $DelayedBorder

func _ready():
	#Make BG transparent
	OS.window_borderless = true

func _on_Panel_mouse_entered():
	delay.stop()
	OS.window_borderless = false


func _on_Panel_mouse_exited():
	delay.start()


func _on_DelayedBorder_timeout():
	OS.window_borderless = true
