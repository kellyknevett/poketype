extends Sprite2D
@onready var main_pokemon_audio: AudioStreamPlayer = $MainPokemonAudio

@onready var enemy: Node2D = $"../enemy"
@onready var main_pokemon_animation: AnimationPlayer = $MainPokemonAnimation
signal tackle_hit(damage)
signal gold_changed
var gold

func _ready() -> void:
	gold = 0
	enemy.connect("enemy_struck",_on_enemy_struck)
	enemy.connect("enemy_died",_on_enemy_died)
	main_pokemon_animation.speed_scale = 1.5
	pass


func _on_enemy_struck() -> void:
	print("We did a word!")
	main_pokemon_animation.play("tackle")
	_play_tackle()
	tackle_hit.emit(40)
	main_pokemon_audio.play()
	
	
func _play_tackle() -> void:
	main_pokemon_audio.pitch_scale = randf_range(0.8,1.2)
	main_pokemon_audio.play()
	
func _on_enemy_died(enemy_gold) -> void:
	gold += enemy_gold
	gold_changed.emit(gold)
	print("Foe slain!")
