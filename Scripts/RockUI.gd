extends Node2D
class_name RockUI

@onready var healthBar: ProgressBar = get_node("Health/HealthBar");

var MAX_HEALTH = 10;
var health: int = 10;

func takeDamage(damage: int):
  health -= damage;
  updateBar();


func updateBar():
  healthBar.max_value = MAX_HEALTH;
  healthBar.min_value = 0;
  healthBar.value = health;
