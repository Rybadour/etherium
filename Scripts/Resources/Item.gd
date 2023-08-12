extends Resource
class_name Item

@export var name: String;
@export var slotType: Globals.SlotType;
@export var implicits: Array[Modifier];
@export var affixes: Array[Affix];
var totalWeight: int;

func _ready():
	for affix in affixes:
		totalWeight += affix.totalWeight;
