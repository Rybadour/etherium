class_name ItemConfig

var shittyAffixes: Array[Affix] = [
	Affix.new(Globals.AffixType.Prefix, Globals.StatType.MiningPower, generateAffixTiers(4, 1000, 5, 5)),
	Affix.new(Globals.AffixType.Prefix, Globals.StatType.IncreasedMiningPower, generateAffixTiers(4, 1000, 20, 5)),
	Affix.new(Globals.AffixType.Prefix, Globals.StatType.FireDamage, generateAffixTiers(4, 1000, 2, 3)),
	Affix.new(Globals.AffixType.Prefix, Globals.StatType.IncreasedFireDamage, generateAffixTiers(4, 1000, 20, 5))
];

var weaponItems: Array[Item] = [
	Item.new(
		"Wooden Pickaxe",
		Globals.SlotType.Weapon, [
			Modifier.new(Globals.StatType.MiningPower, [
				ModifierTier.new(1, 1, 10),
			])
		],
		shittyAffixes
	)
];

var helmetItems: Array[Item] = [
	Item.new(
		"Baseball Cap",
		Globals.SlotType.Head, [
			Modifier.new(Globals.StatType.OilCapacity, [
				ModifierTier.new(1, 20, 40),
			])
		],
		shittyAffixes
	)
];

var chestItems: Array[Item] = [
	Item.new(
		"Safety Vest",
		Globals.SlotType.Chest, [
			Modifier.new(Globals.StatType.OilCapacity, [
				ModifierTier.new(1, 20, 40),
			])
		],
		shittyAffixes
	)
];

var glovesItems: Array[Item] = [
	Item.new(
		"Fingerless Gloves",
		Globals.SlotType.Gloves, [
			Modifier.new(Globals.StatType.IncreasedActionSpeed, [
				ModifierTier.new(1, 20, 40),
			])
		],
		shittyAffixes
	)
];

var amuletItems: Array[Item] = [
	Item.new(
		"Stinky Lanyard",
		Globals.SlotType.Amulet, [
			Modifier.new(Globals.StatType.FireDamage, [
				ModifierTier.new(1, 5, 10),
			])
		],
		shittyAffixes
	)
];

var ringItems: Array[Item] = [
	Item.new(
		"Plastic Ring",
		Globals.SlotType.Ring, [
			Modifier.new(Globals.StatType.FireDamage, [
				ModifierTier.new(1, 5, 10),
			])
		],
		shittyAffixes
	)
];

var bootsItems: Array[Item] = [
	Item.new(
		"Sneakers",
		Globals.SlotType.Boots, [
			Modifier.new(Globals.StatType.MovementSpeed, [
				ModifierTier.new(1, 5, 30),
			])
		],
		shittyAffixes
	)
];

func generateAffixTiers(numTiers: int, startWeight: int, statStart: int, statChange: int):
	var affixes: Array[ModifierTier];
	for i in numTiers:
		affixes.append(ModifierTier.new(startWeight, statStart, statStart + statChange));
		startWeight /= 2;
		statStart += statChange;
	return affixes;
