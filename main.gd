extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	$HUD.changed_running.connect(_change_generation_timer)
	$HUD.reseted.connect(_reset)
	$HUD.displayed_config.connect(func():$ConfigDisplay.visible=true)
	$HUD.changed_hp_label_display.connect(func(is_visible:bool):$CanvasLayer/CellTileMap.change_visible_hp_label(is_visible))
	
	$CanvasLayer/CellTileMap.init_cell_tile_map()

	_count_cells()

	_set_generation_speed()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


# 特定の秒数で動く
func _on_generation_timer_timeout() -> void:
	_generation()

# 1世代毎の動作
func _generation() -> void:
	# 周囲に影響を与える
	CellManager.influence()
	
	# 死亡からのセルの変化
	CellManager.change()

	# HPのリフレッシュ
	CellManager.refresh_hp()
	
	_count_cells()

func _change_generation_timer(running:bool) -> void:
	if running: 
		$GenerationTimer.start()
	else:
		$GenerationTimer.stop()

func _reset() -> void:
	CellManager.erase_cells()
	$CanvasLayer/CellTileMap.clear_cell_tile_map()
	$CanvasLayer/CellTileMap.init_cell_tile_map()
	_count_cells()
	
	_set_generation_speed()
	
	$HUD.init_hud()

func _set_generation_speed() -> void:
	$GenerationTimer.wait_time = ConfigManager.get_config("generation_speed")

func _count_cells() -> void:
	var count_dict:Dictionary = CellManager.count_cells()
	$HUD.change_count_text(count_dict)
	
