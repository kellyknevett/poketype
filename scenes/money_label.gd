extends RichTextLabel


@onready var main_pokemon: Sprite2D = $"../../../MainPokemon"


func _ready() -> void:
	main_pokemon.connect("gold_changed",_on_gold_changed)
	pass
func _on_gold_changed(gold: int) -> void:
	print("Gold change!")
	text = str(gold)
