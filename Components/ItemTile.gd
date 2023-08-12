extends Control
class_name ItemTile

@onready var textureRect: TextureRect = find_child('TextureRect');
@onready var nameLabel: Label = get_node("MarginContainer/MarginContainer/HBoxContainer/Name");
@onready var implicit1: Label = get_node("MarginContainer/MarginContainer/HBoxContainer/Implicit1");

var item: RealItem;
@export var icon: Texture2D;

# Called when the node enters the scene tree for the first time.
func _ready():
	textureRect.texture = icon;
	if (item != null):
		nameLabel.text = item.fullName;
		implicit1.text = getModifierText(item.implicits.keys()[0], item.implicits.values()[0]);
		

func getModifierText(stat: Globals.StatType, value: float):
	var text = '';
	if stat == Globals.StatType.MiningPower:
		text = str(value) + ' Mining Power';
	return text;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
