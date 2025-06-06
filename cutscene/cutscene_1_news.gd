extends Control

@onready var dialogue_label: Label = $Label

var full_text := ""
var current_text := ""
var letter_index := 0
var is_typing := false
var typing_speed := 0.03  
var dialogue_count = 0

func _ready():
		start_dialogue("Breaking news: Chaos erupts worldwide as an\nunknown force invades Earth.")
		dialogue_count = 1

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		if is_typing:
			skip_typing()
		else:
			if dialogue_count == 1:
				start_dialogue("The Zephyrus has landed with one goal —\ntotal control over human evolution.")
				dialogue_count += 1
			elif dialogue_count == 2:
				start_dialogue("Instead of peace, they’ve chosen destruction.\nCities are crumbling. Panic is everywhere.")
				dialogue_count += 1
			elif dialogue_count == 3:
				start_dialogue("Worse, they’ve released a fast-spreading virus,\ninfecting our own fallen soldiers.")
				dialogue_count += 1
			elif dialogue_count == 4:
				start_dialogue("Most of our defenses are down...\nonly one soldier remains.")
				dialogue_count += 1
			elif dialogue_count == 5:
				start_dialogue("Oh—hold on. We’re getting a transmission from one of our experts.\nA message for the last hope...")
				dialogue_count += 1
			elif dialogue_count ==6:
				start_dialogue("Hello,sir? Can you hear us?")
				dialogue_count +=1
			elif dialogue_count == 7:
				start_dialogue("Unknown: Hi... yes yes..")
				dialogue_count +=1
			elif dialogue_count == 8:
				start_dialogue("Sir, what is your message to the last warrior who is out there?")
				dialogue_count +=1
			elif dialogue_count ==9:
				start_dialogue("Unknown: Warrior, I hope you are listening to me right now. You must stop them before it's too late.")
				dialogue_count +=1
			elif dialogue_count == 10:
				start_dialogue("Unknown: There are five locations... each crawling with enemies.")
				dialogue_count +=1
			elif dialogue_count == 11:
				start_dialogue("Unknown: You must travel to each place and stop the enemy before they plunge the world into chaos.")
				dialogue_count +=1
			elif dialogue_count == 12:
				start_dialogue("Unknown: But beware — at every location, a powerful boss awaits. Only by defeating them can you hope to end this nightmare.")
				dialogue_count +=1
			elif dialogue_count == 13:
				start_dialogue("Unknown: Before facing each boss, there is a special object.\nYou must interact with it to unlock the path forward.")
				dialogue_count +=1
			elif dialogue_count == 14:
				start_dialogue("Unknown: The fate of everything rests on your shoulders now. Your journey to the right is the only path to end this war..*kzzt— BEEP —connection lost...*")
				dialogue_count +=1
			elif dialogue_count == 15:
				start_dialogue("Seems like we’ve lost his connection...")
				dialogue_count += 1
			elif dialogue_count == 16:
				start_dialogue("To the warrior out there — if you’re still listening... we need you. The enemy is getting stronger, and people are losing hope.")
				dialogue_count += 1
			elif dialogue_count == 17:
				start_dialogue("You're the only one who can turn this around.")
	
				await wait_for_typing_done()
				await get_tree().create_timer(3.0).timeout
				get_tree().change_scene_to_file("res://cutscene/cutscene_2_vid.tscn")
	
			else:
				print("No more dialogue.")


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
	current_text = full_text
	dialogue_label.text = full_text
	
func wait_for_typing_done():
	while is_typing:
		await get_tree().process_frame
