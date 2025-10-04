extends Node2D
var words = ["dog","cat","mouse"]#@onready var active_word_label: RichTextLabel = $ActiveWordLabel
@onready var active_word_label: RichTextLabel = $EnemySprite/ActiveWordLabel

var active_word = "NONE!"
signal enemy_struck
signal enemy_died(gold)
@onready var health_bar: ProgressBar = $HealthBar
@onready var world: Node2D = $".."
@onready var enemy_sprite: Sprite2D = $EnemySprite

@onready var main_pokemon: Sprite2D = $"../MainPokemon"
var level
var base_health = 100
var health
func _ready() -> void:
	words = _build_words()
	print(str(world.monster_level) + "MONSTER LEVEL!")
	health = base_health * (world.monster_level * 2)
	var random = randi_range(0,words.size())
	active_word = " ".join(words[random].split(""))
	update_active_word()
	main_pokemon.connect("tackle_hit",_tackle_hit)
	health_bar.value = health
	health_bar.max_value = health
	

func to_string_green(input: String) -> String:
	input = input + "[/shake][/color]"
	input = "[color=yellow][shake rate=5.0 level=10 connected=1]" + input
	return input

func _input(event: InputEvent) -> void:
	if event.is_pressed() and not event.is_echo():
		print(event.as_text())
		_check_input_hit(event)
		
func _process(delta: float) -> void:
	#health_bar.max_value = health
	pass
		
func update_active_word() -> void:
	active_word_label.text = to_string_green(active_word)

func _check_input_hit(event: InputEvent) -> void:
	if active_word.length() > 0 and event.as_text().to_lower() == active_word[0].to_lower() and event.is_pressed():
		print("Character match")
		print(active_word)
		if active_word.length() > 1:
			active_word = active_word.trim_prefix(active_word[0] + " ")
		else:
			active_word = active_word.trim_prefix(active_word[0])
		update_active_word()
	else:
		print("expected: "+active_word[0] +  " but recieved" + event.as_text().to_lower())
	if active_word.length() <= 0:
		print("Enemy hit!")
		emit_signal("enemy_struck")
		var random = randi_range(0,words.size())
		active_word = " ".join(words[random].split(""))
		update_active_word()

func _tackle_hit(damage: float) -> void:
	print("Hit for "+str(damage))
	health -= damage
	health_bar.value = health
	if health <= 0:
		_spawn_new_enemy()
		print("Enemy Died!")
		
func _spawn_new_enemy() -> void:
	enemy_died.emit(world.monster_level * 10)
	health = base_health * (world.monster_level * 2)
	enemy_sprite.texture = world.pokemon.pick_random()["sprite"]
	health_bar.value = health
	health_bar.max_value = health

func _build_words() -> PackedStringArray:
	var file = FileAccess.open("res://common words.txt", FileAccess.READ)
	if file == null:
		print("Error opening file: ")
		return PackedStringArray() # Return an empty array on error

	var lines: PackedStringArray
	while not file.eof_reached():
		var line = file.get_line()
		if not line.is_empty(): # Optional: skip empty lines
			lines.append(line)

	file.close()
	return lines
	
	
