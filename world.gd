extends Node2D

const DITTO = preload("uid://dvkr7apjg46hy")
const DURANT = preload("uid://ch530wgmo410h")
const WYNAUT = preload("uid://j8r6styju41h")
const DUNSPARCE = preload("uid://dahmqqyap66if")
var monster_level := 1

var pokemon := [{
	"name": "ditto",
	"sprite": DITTO
},

{
	"name": "durant",
	"sprite": DURANT
},

{
	"name": "dunsparce",
	"sprite": DUNSPARCE
},

{
	"name": "wynaut",
	"sprite": WYNAUT
},

]

#func _ready() -> void:
#	animation_player.speed_scale = 0.8
#	animation_player.play("map2")
