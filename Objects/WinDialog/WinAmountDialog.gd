extends Popup


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

onready var label_text = $Label

func show() -> void:
	popup()
	$Timer.start()

func winRed(redPoints: int, bluePoints: int) -> void:
	label_text.text = "Red won by " + str(redPoints) + " to " + str(bluePoints)
	show()

func winBlue(redPoints: int, bluePoints: int) -> void:
	label_text.text = "Blue won by " + str(bluePoints) + " to " + str(redPoints)
	show()


func resetMessage() -> void:
	label_text.text = "Game has been resetted"
	show()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_Timer_timeout() -> void:
	hide()
