extends Node

signal file_read(quote)

var quotes_col : JSONParseResult
var current_quote : int = 0
var max_quotes : int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().get_root().set_transparent_background(true)
	randomize()
	var file = File.new()
	file.open("res://Quotes.txt", File.READ)
	var content = file.get_as_text()
	quotes_col  = JSON.parse(content)
	max_quotes = quotes_col.result.size()
	current_quote = randi()%max_quotes
	var entity = quotes_col.result[current_quote]
	show_quote(entity["quote"], entity["author"])
	file.close()
	#return content

func next_quote():
	current_quote+=1
	if(current_quote>=max_quotes):
		current_quote=0
	var entity = quotes_col.result[current_quote]
	show_quote(entity["quote"], entity["author"])

func show_quote(quote : String, author:String):
	var txt = author+" "+quote
	emit_signal("file_read", txt)


func _on_Timer_timeout():
	next_quote()
