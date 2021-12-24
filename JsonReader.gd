extends Node

#signal file_read(quote)

var quotes_col : JSONParseResult
var current_quote : int = 0
var max_quotes : int = 0

onready var quote_label : Label = $Control/Quote
onready var author_label : Label = $Control/Author
onready var tags_label : Label = $Control/Tags

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
	show_quote(entity)
	file.close()
	#return content

func next_quote():
	print("call")
	current_quote+=1
	if(current_quote>=max_quotes):
		current_quote=0
	var entity = quotes_col.result[current_quote]
	show_quote(entity)

func show_quote(entity : Dictionary):
	quote_label.text = entity["quote"]
	author_label.text = entity["author"]
	tags_label.text = entity["tags"][0]


func _on_Timer_timeout():
	next_quote()
