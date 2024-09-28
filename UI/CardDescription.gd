extends Control

var key_words: Dictionary
#Key words are parameters(or numbers), and effects are separate buffs/debuffs
export var effect_words: Dictionary
export var features_words: Dictionary

onready var my_description: RichTextLabel = $Panel/Description
onready var energy: Label = $Energy/Label #I had to separate the description and 
#the energy indicator to avoid conflicts. Maybe I'll find another solution

var initial_text: String

export var description_panel: PackedScene
var shown_description: CanvasLayer = null #The one that's being shown ones the cursor is on the key word

func _ready():
	initial_text = get_text()

func set_description(): #Key words and effect words use different formulas, so
	#I had to create two separate for-loops, unfortunately
	var new_text = initial_text
	my_description.bbcode_text = initial_text
	set_text(new_text, features_words, true)
	set_text(new_text, effect_words, false)
	for word in key_words:
		new_text = my_description.bbcode_text.replace(word, str(key_words[word]))
		my_description.bbcode_text = new_text
	if key_words["[value]"] != 0:
		new_text = "DMG: "+ str(key_words["[value]" ] ) +"  " + str(new_text)
	my_description.bbcode_text = "[center]%s[/center]" % new_text
	energy.text = str(key_words["[required_energy]"])

func set_text(text, type_of_words, feature: bool = false):
	for word in type_of_words:
		if feature:
			my_description.bbcode_text += str(word +(", " if type_of_words.keys().back() != word else ""))
		text = my_description.bbcode_text.replace(word,
		 ("[url=%s]" % type_of_words[word])+ ("[color=#18e4ff]%s[/color]" % word)+"[/url]")
		my_description.bbcode_text = text

func set_words(dict: Dictionary, type: String):
	match type:
		"feature":
			features_words.merge(dict, true)
		"key":
			key_words.merge(dict, true)
		"effect":
			effect_words.merge(dict, true)
	set_description()

#func set_effects(dict: Dictionary):
#	effect_words.merge(dict, true)
##	for word in dict:
##		effect_words[word] = dict[word]
#	set_description()
#
#func set_key_words(dict: Dictionary):
#	key_words.merge(dict, true)
#	set_description()

func define_owner(my_owner: Card):
	my_description.my_owner = my_owner

func get_text():
	return my_description.bbcode_text

func _on_RichTextLabel_meta_hover_started(meta):
	var description = description_panel.instance()
#	description.add_to_group("deleatable")
	description.new_text = meta
	add_child(description)
	shown_description = description

func _on_RichTextLabel_meta_hover_ended(_meta):
	if shown_description != null:
		shown_description.queue_free()
		shown_description = null #Otherwise we have "previously freed instance"
#	for child in get_children():
#		if child.is_in_group("deleatable"):
#			child.queue_free()
