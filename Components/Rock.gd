extends Node2D
class_name Rock

@onready var healthBar: ProgressBar = get_node("Health/HealthBar");

var MAX_HEALTH = 30;
var health: int = 30;

func _ready():
	updateBar();


func takeDamage(damage: int):
	health -= damage;
	updateBar();


func updateBar():
	healthBar.visible = health < MAX_HEALTH;
	healthBar.max_value = MAX_HEALTH;
	healthBar.min_value = 0;
	healthBar.value = health;
