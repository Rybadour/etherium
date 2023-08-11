extends Resource
class_name Item

enum SlotType {Weapon, Head, Chest, Amulet, Ring, Gloves, Boots}

@export var name: String;
@export var slotType: SlotType;
@export var implicits: Array[Modifier] 
@export var affixes: Array[Affix];
var totalWeight: int;

func _ready():
  for affix in affixes:
    totalWeight += affix.totalWeight;
