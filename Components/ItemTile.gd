extends Control
class_name ItemTile

@onready var textureRect: TextureRect = find_child('TextureRect');
@onready var nameLabel: Label = get_node("MarginContainer/MarginContainer/HBoxContainer/Name");
@onready var implicit1: Label = get_node("MarginContainer/MarginContainer/HBoxContainer/Implicit1");

var item: Item;
@export var icon: Texture2D;

# Called when the node enters the scene tree for the first time.
func _ready():
	textureRect.texture = icon;
	if (item != null):
		nameLabel.text = item.name;
		implicit1.text = item.prefixes[0];


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
