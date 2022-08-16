extends Control


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

onready var upPlayerScore = get_node("UpPlayerScore")
onready var downPlayerScore = get_node("DowPlayerScore")

func resetScores():
	upPlayerScore.text = str(0)
	downPlayerScore.text = str(0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	resetScores()

func add1ToScore(label: Label):
	label.text = str(int(label.text) + 1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_Game_update_score(who: String) -> void:
	if who == "UP":
		add1ToScore(upPlayerScore)
	else:
		add1ToScore(downPlayerScore)
