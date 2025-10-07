extends Sprite2D
@onready var main_pokemon_audio: AudioStreamPlayer = $MainPokemonAudio

@onready var enemy: Node2D = $"../enemy"
@onready var main_pokemon_animation: AnimationPlayer = $MainPokemonAnimation
signal tackle_hit(damage)
signal gold_changed
signal level_up(level)
var gold
var level
var level_damage_scale = 2
var base_damage = 300
var xp = 0

func _ready() -> void:
	level = 0
	gold = 0
	enemy.connect("enemy_struck",_on_enemy_struck)
	enemy.connect("enemy_died",_on_enemy_died)
	main_pokemon_animation.speed_scale = 1.5
	pass


func _on_enemy_struck() -> void:
	var damage = base_damage + (level  * base_damage)
	
	#print("We did a word!")
	main_pokemon_animation.play("tackle")
	_play_tackle()
	tackle_hit.emit(damage)
	main_pokemon_audio.play()
	
	
func _play_tackle() -> void:
	main_pokemon_audio.pitch_scale = randf_range(0.8,1.2)
	main_pokemon_audio.play()
	
func _on_enemy_died(enemy_gold) -> void:
	gold += enemy_gold
	gold_changed.emit(gold)
	print("Foe slain!")
	xp += 10
	if xp > 10:
		print("main leveled up")
		xp = 0
		level += 1
		level_up.emit(level + 1)
