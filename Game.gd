extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var selector = $Selector
const CELL_SIZE = 40
const MARGIN = 40
const CELL_PADDING_SELECTOR = 25
var current_column = 0

onready var current_game_grid = $GameGrid as GameGrid

func setup_selector_position(gameGrid):
	current_column = 0
	return gameGrid.rect_position - Vector2(CELL_PADDING_SELECTOR,CELL_PADDING_SELECTOR)

# Called when the node enters the scene tree for the first time.
func _ready():
	
	selector.rect_position = setup_selector_position($GameGrid)

func _input(event):
	if event.is_action_pressed("ui_down"):
		current_game_grid = $GameGrid2
		selector.rect_position = setup_selector_position(current_game_grid)
	if event.is_action_pressed("ui_up"):
		current_game_grid = $GameGrid
		selector.rect_position = setup_selector_position(current_game_grid)
	
	
	if event.is_action_pressed("ui_left"):
		if current_column > 0:
			selector.rect_position.x -= (CELL_SIZE + MARGIN)
			current_column -= 1
	if event.is_action_pressed("ui_right"):
		if current_column < 2:
			selector.rect_position.x += (CELL_SIZE + MARGIN) 
			current_column += 1
			
	if event.is_action_pressed("select_column"):
		var children = current_game_grid.getAllCells(current_game_grid.griglia)
		var res = current_game_grid.getColumnByIndex(current_game_grid.griglia, current_column)
		
	print(current_column)
	



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
