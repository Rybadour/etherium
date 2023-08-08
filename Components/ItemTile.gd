extends Control
class_name ItemTile

@onready var textureRect: TextureRect = find_child('TextureRect');

@export var itemName: String;
@export var icon: Texture2D;

# Called when the node enters the scene tree for the first time.
func _ready():
	textureRect.texture = icon;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
