extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

signal file_read(quote)

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	var file = File.new()
	file.open("res://Quotes.txt", File.READ)
	var content = file.get_as_text()
	var json_read : JSONParseResult = JSON.parse(content)
	var entities_size : int = json_read.result.size()
	var entity = json_read.result[randi()%entities_size]
	var txt = (entity["author"]+" "+entity["quote"])
	print(entity["tags"])
	emit_signal("file_read", txt)
	file.close()
	#return content


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
