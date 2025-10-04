extends Control


@onready var world: Node2D = $".."

@onready var map_animation: AnimationPlayer = $MapAnimation

@onready var scrolling_bg: TextureRect = $scrolling_bg

var animations = ["map1","map2"]
var animation_index = randi_range(0,animations.size()-1)


func _ready() -> void:
	
	
	
	map_animation.connect("animation_finished",_bg_transition)
	_bg_transition("null")
	#animation_player.get_animation_library()
	
func _bg_transition(_anim_name: String) -> void:
	print("Animation start!")
	animation_index = randi_range(0,animations.size()-1)
	map_animation.play(animations[animation_index])
	
