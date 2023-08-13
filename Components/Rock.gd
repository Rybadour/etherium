extends Node2D
class_name Rock

@onready var healthBar: ProgressBar = get_node("Health/HealthBar");

var maxHealth: int;
var health: int;
var ore: Globals.OreType;
var oreYield: int;

func setup(health: int, ore: Globals.OreType, oreYield: int):
	self.health = health;
	self.maxHealth = health;
	self.ore = ore;
	self.oreYield = oreYield;


func _ready():
	updateBar();


func takeDamage(damage: int):
	health -= damage;
	updateBar();


func updateBar():
	healthBar.visible = health < maxHealth;
	healthBar.max_value = maxHealth;
	healthBar.min_value = 0;
	healthBar.value = health;
