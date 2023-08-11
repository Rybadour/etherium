extends Resources
class_name Modififer

@export var stat: StatType;
@export var tiers: Array[ModifierTier];
var totalWeight: int;

func _ready():
  for tier in tiers:
    totalWeight += tier.weight;


func generateModifierAmount(relativeRoll: int):
  for tier in tiers:
    if relativeRoll < tier.weight:
      return tier.statMin;
    else:
      relativeRoll -= tier.weight;