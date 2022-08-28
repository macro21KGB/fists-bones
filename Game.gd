extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var selector = $Selector
const CELL_SIZE = 40
const MARGIN = 40
const CELL_PADDING_SELECTOR = 25

signal update_score

var current_column = 0
var current_dice_roll 

onready var grids = [$GameGrid, $GameGrid2]
onready var current_game_grid = grids[0]
onready var dice_thrower_text = $DiceThrower/Dice
onready var popup_points = $WinAmountDialog 


func checkGridsMatch(gridAttacker : GameGrid, gridDefender : GameGrid, column_idx: int):
	var attacker_column = gridAttacker.getColumnByIndex(gridAttacker.griglia, column_idx)
	var other_column = gridDefender.getColumnByIndex(gridDefender.griglia, column_idx)

	for cell in attacker_column:
		for other_cell in other_column:
			if cell.getDiceValue() == other_cell.getDiceValue():
				other_cell.setDiceValue(0)


func switchGameGrid():
	if current_game_grid == grids[0]:
		current_game_grid = grids[1]
	else:
		current_game_grid = grids[0]

func selectOtherGameGrid(current_grid):
	if current_grid == grids[0]:
		return grids[1]
	else:
		return grids[0]

func setNewDiceRoll():
	current_dice_roll = Utils.generateDiceRoll()
	dice_thrower_text.text = str(current_dice_roll)

func setupSelectorPosition(gameGrid):
	current_column = 0
	return gameGrid.rect_position - Vector2(CELL_PADDING_SELECTOR,CELL_PADDING_SELECTOR)

# Called when the node enters the scene tree for the first time.
func _ready():
	setNewDiceRoll()
	selector.rect_position = setupSelectorPosition(grids[0])
	GameEvents.connect("restart_game", self, "_on_game_restart")


func _input(event):
	if event.is_action_pressed("ui_left"):
		if current_column > 0:
			selector.rect_position.x -= (CELL_SIZE + MARGIN)
			current_column -= 1
	if event.is_action_pressed("ui_right"):
		if current_column < 2:
			selector.rect_position.x += (CELL_SIZE + MARGIN) 
			current_column += 1
			
	if event.is_action_pressed("select_column"):
		doTurn()

func doTurn() -> void:
	if current_game_grid.addDiceToColumn(current_dice_roll, current_column):
		checkGridsMatch(current_game_grid, selectOtherGameGrid(current_game_grid), current_column)
		setNewDiceRoll()
		
		# go to next turn updatin the total count
		GameEvents.emit_signal("next_turn", current_game_grid)
		
		switchGameGrid()
		selector.rect_position = setupSelectorPosition(current_game_grid)


func resetGame():
	grids[0].resetGrid()
	grids[1].resetGrid()
	setNewDiceRoll()

func _on_GameGrid_grid_is_full() -> void:
	var totalSumOfUpGrid = Utils.sumItemInArray(grids[0].getValueForEveryColumn())
	var totalSumOfDownGrid = Utils.sumItemInArray(grids[1].getValueForEveryColumn())
	
	if totalSumOfUpGrid > totalSumOfDownGrid:
		popup_points.winRed(totalSumOfUpGrid, totalSumOfDownGrid)
		emit_signal("update_score", "UP")
	else:		
		popup_points.winBlue(totalSumOfUpGrid, totalSumOfDownGrid)
		emit_signal("update_score", "DOWN")
		
	grids[0].resetGrid()
	grids[1].resetGrid()


func _on_game_restart():
	resetGame()

