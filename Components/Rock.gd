extends Node2D
class_name Rock

@onready var healthBar: ProgressBar = get_node("Health/HealthBar");

var MAX_HEALTH = 10;
var health: int = 10;

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
