extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var file = File.new()
	file.open("res://Quotes.txt", File.READ)
	var content = file.get_as_text()
	var json_read : JSONParseResult = JSON.parse(content)
	print(json_read.result["entities"][0]["name"])
	file.close()
	#return content


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
