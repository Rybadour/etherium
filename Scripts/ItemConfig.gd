class_name ItemConfig

var weaponItems: Array[Item] = [
	Item.new(
	"Wooden Pickaxe",
	Globals.SlotType.Weapon, [
		Modifier.new(Globals.StatType.MiningPower, [
			ModifierTier.new(1, 1, 10),
		])
	], [
		Affix.new(Globals.AffixType.Prefix, Globals.StatType.IncreasedMiningPower, generateAffixTiers(4, 1000, 20, 5)),
		Affix.new(Globals.AffixType.Prefix, Globals.StatType.FireDamage, generateAffixTiers(4, 1000, 2, 3))
	]
	)
]

func generateAffixTiers(numTiers: int, startWeight: int, statStart: int, statChange: int):
	var affixes: Array[AffixTier];
	for i in numTiers:
		affixes.append(AffixTier.new(startWeight, statStart, statStart + statChange));
		startWeight /= 2;
		statStart += statChange;
	return affixes;
