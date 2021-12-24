extends Node

#signal file_read(quote)

var quotes_col : JSONParseResult
var current_quote : int = 0
var max_quotes : int = 0

onready var group_label : Control = $Control
onready var quote_label : Label = $Control/Quote
onready var author_label : Label = $Control/Author
onready var tags_label : Label = $Control/Tags

onready var fadeIn : Tween = $FadeIn
onready var fadeOut : Tween = $FadeOut

onready var timer : Timer = $NextQuote

# Called when the node enters the scene tree for the first time.
func _ready():
	#Fades
	var _inter = fadeIn.interpolate_property(group_label, "modulate", Color(1,1,1,1), Color(1,1,1,0), 1, Tween.TRANS_LINEAR, Tween.EASE_IN)
	_inter = fadeOut.interpolate_property(group_label, "modulate", Color(1,1,1,0), Color(1,1,1,1), 1, Tween.TRANS_LINEAR, Tween.EASE_IN)
	
	get_tree().get_root().set_transparent_background(true)
	randomize()
	var file = File.new()
	file.open("res://Quotes.txt", File.READ)
	var content = file.get_as_text()
	quotes_col  = JSON.parse(content)
	max_quotes = quotes_col.result.size()
	current_quote = randi()%max_quotes
	#var entity = quotes_col.result[current_quote]
	update_quote()
	fadeOut.start()
	file.close()
	#return content

func next_quote():
	print("next quote")
	current_quote+=1
	if(current_quote>=max_quotes):
		current_quote=0
	#fadeIn.reset_all()
	var _inter = fadeIn.interpolate_property(group_label, "modulate", Color(1,1,1,1), Color(1,1,1,0), 1, Tween.TRANS_LINEAR, Tween.EASE_IN)
	fadeIn.start()

func update_quote():
	var entity = quotes_col.result[current_quote]
	quote_label.text = entity["quote"]
	author_label.text = entity["author"]
	var tags_found = entity["tags"]
	tags_label.text = "tags:"
	#TODO: Add commas
	for i in tags_found:
		tags_label.text += i+" "


func _on_Timer_timeout():
	next_quote()
	timer.stop()


func _on_FadeOut_tween_completed(object, key):
	timer.start()


func _on_FadeIn_tween_completed(object, key):
	update_quote()
	var _inter = fadeOut.interpolate_property(group_label, "modulate", Color(1,1,1,0), Color(1,1,1,1), 1, Tween.TRANS_LINEAR, Tween.EASE_IN)
	fadeOut.start()
