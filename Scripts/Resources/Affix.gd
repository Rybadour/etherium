extends Resource
class_name Affix

@export var id: String;
@export var itemNameMod: String;
@export var descriptionTemplate: String;
@export var type: Globals.AffixType;
@export var stat: Globals.StatType;
@export var tiers: Array[AffixTier];
var totalWeight: int;

func _ready():
	for tier in tiers:
		totalWeight += tier.totalWeight;


func generateModifierAmount(relativeRoll: int):
	for tier in tiers:
		if relativeRoll < tier.weight:
			return tier.statMin;
		else:
			relativeRoll -= tier.weight;
