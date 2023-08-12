class_name Affix

var type: Globals.AffixType;
var stat: Globals.StatType;
var tiers: Array[AffixTier];
var totalWeight: int;

func _init(type: Globals.AffixType, stat: Globals.StatType, tiers: Array[AffixTier]):
	self.type = type;
	self.stat = stat;
	self.tiers = tiers;
	for tier in tiers:
		totalWeight += tier.weight;


func generateModifierAmount(relativeRoll: int):
	for tier in tiers:
		if relativeRoll < tier.weight:
			return tier.statMin;
		else:
			relativeRoll -= tier.weight;
