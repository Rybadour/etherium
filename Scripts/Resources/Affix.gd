extends Resource
class_name Affix

enum AffixType {Prefix, Suffix}

@export var id: String;
@export var itemNameMod: String;
@export var descriptionTemplate: String;
@export var type: AffixType;
@export var stat: StatType;
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