extends Control

@onready var dialogue_label: Label = $Label

var full_text := ""
var current_text := ""
var letter_index := 0
var is_typing := false
var typing_speed := 0.03  
var dialogue_count = 0

func _ready():
	start_dialogue("Breaking news: Chaos erupts worldwide as an
	 unknown force invades Earth. ")
	dialogue_count = 1

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"): 
		if is_typing:
			skip_typing()
		else:
			if dialogue_count == 1:
				start_dialogue("The Zephyrus has landed with one goal —
				 total control over human evolution.")
				dialogue_count += 1
			elif dialogue_count == 2:
				start_dialogue("Instead of peace, they’ve chosen destruction.
				 Cities are crumbling. Panic is everywhere.")
				dialogue_count += 1
			elif dialogue_count == 3:
				start_dialogue("Worse, they’ve released a fast-spreading virus, 
				infecting our own fallen soldiers.")
				dialogue_count += 1
			elif dialogue_count ==4:
				start_dialogue("Most of our defenses are down...
				 only one soldier remains.")
				dialogue_count += 1
			elif dialogue_count == 5:
				start_dialogue("Oh—hold on. We’re getting a transmission from 
			one of our experts. A message for the last hope.")
				
			else:
				print("no more")

func start_dialogue(text: String):
	full_text = text
	current_text = ""
	letter_index = 0
	is_typing = true
	dialogue_label.text = ""
	type_next_letter()

func type_next_letter():
	if letter_index < full_text.length():
		current_text += full_text[letter_index]
		dialogue_label.text = current_text
		letter_index += 1
		await get_tree().create_timer(typing_speed).timeout
		if is_typing: 
			type_next_letter()
	else:
		is_typing = false

func skip_typing():
	is_typing = false
	dialogue_label.text = full_text
