extends Node

#signal file_read(quote)

export(float) var fade_time = 1

var quotes_col : JSONParseResult
var current_quote : int = 0
var max_quotes : int = 0

onready var group_label : Control = $Control
onready var quote_label : Label = $Control/Quote
onready var author_label : Label = $Control/Quote/Author
onready var tags_label : Label = $Control/Quote/Tags

onready var fadeIn : Tween = $FadeIn
onready var fadeOut : Tween = $FadeOut

onready var timer : Timer = $NextQuote

# Called when the node enters the scene tree for the first time.
func _ready():
	#Fades
	var _inter = fadeIn.interpolate_property(group_label, "modulate", Color(1,1,1,1), Color(1,1,1,0), fade_time, Tween.TRANS_LINEAR, Tween.EASE_IN)
	_inter = fadeOut.interpolate_property(group_label, "modulate", Color(1,1,1,0), Color(1,1,1,1), fade_time, Tween.TRANS_LINEAR, Tween.EASE_IN)
	
	randomize()
	var file = File.new()
	if file.file_exists("res://Quotes.txt"):
		var err = file.open("res://Quotes.txt", File.READ)
		if(err==OK):
			var content = file.get_as_text()
			quotes_col  = JSON.parse(content)
			if typeof(quotes_col.result) == TYPE_ARRAY:
				max_quotes = quotes_col.result.size()
				current_quote = randi()%max_quotes
				update_quote()
				var _fade = fadeOut.start()
			else:
				json_fail()
		else:
			printerr("ERROR: "+err)
	else:
		err_file_not_found()
	file.close()

func json_fail():
	printerr("ERROR: Unable to read JSON format")
	quote_label.text = "JSON format could not be read from \"Quotes.txt\" . Please verify file."
	author_label.text = ""
	tags_label.text = ""

func err_file_not_read():
	quote_label.text = "File \"Quotes.txt\" could not be read. Please close the program and try again."
	author_label.text = ""
	tags_label.text = ""

func err_file_not_found():
	printerr("ERROR: File \"Quotes.txt\" not found.")
	quote_label.text = "Not found \"Quotes.txt\". Please close the program and try again."
	author_label.text = ""
	tags_label.text = ""

func next_quote():
	current_quote+=1
	if(current_quote>=max_quotes):
		current_quote=0
	#fadeIn.reset_all()
	var _inter = fadeIn.interpolate_property(group_label, "modulate", Color(1,1,1,1), Color(1,1,1,0), fade_time, Tween.TRANS_LINEAR, Tween.EASE_IN)
	var _fade = fadeIn.start()

func update_quote():
	var entity = quotes_col.result[current_quote]
	quote_label.text = entity["quote"]
	author_label.text = entity["author"]
	var tags_found = entity["tags"]
	tags_label.text = "tags:"
	#TODO: Add commas
	var size_loop = tags_found.size()
	for i in range(size_loop):
		tags_label.text += tags_found[i]
		if(i<size_loop-1):
			tags_label.text += ", "


func _on_Timer_timeout():
	next_quote()
	timer.stop()


func _on_FadeOut_tween_completed(object, key):
	var _o = object;
	var _k = key;
	timer.start()


func _on_FadeIn_tween_completed(object, key):
	var _o = object;
	var _k = key;
	update_quote()
	var _inter = fadeOut.interpolate_property(group_label, "modulate", Color(1,1,1,0), Color(1,1,1,1), fade_time, Tween.TRANS_LINEAR, Tween.EASE_IN)
	var _s = fadeOut.start()
