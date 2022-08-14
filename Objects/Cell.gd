extends Control
class_name Cell


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export (int) var valore_dado = 0

func set_dice_value(value: int) -> void: 
	valore_dado = value

func get_dice_value() -> int:
	return valore_dado

func format_dice_value(value: int) -> String:
	return str(value)

# Called when the node enters the scene tree for the first time.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Dice.text = format_dice_value(valore_dado)

