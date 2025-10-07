extends Label

@onready var main_pokemon: Sprite2D = %MainPokemon

func _ready() -> void:
	main_pokemon.connect("level_up",_update_level)
	
func _update_level(level) -> void:
	print("fired - updated level" + str(level))
	text = str(level)
