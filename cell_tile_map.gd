extends TileMap

@export var hp_label_scene: PackedScene

# セルサイズそのままだと六角形なので縦の高さが合わないため、3/4する
var cell_size := Vector2(tile_set.tile_size) * transform.get_scale()
var cell_size2 = Vector2(cell_size.x, cell_size.y * 3/4) 
# 表示サイズ
@onready var viewport_size := get_viewport_rect().size
# タイルマップ
@onready var tile_map: Vector2i = (viewport_size / cell_size2).ceil()

# XとY方向の上限
# -1しているのはoffset分表示がずれて端が切れるため
@onready var X_MAX: int = tile_map.x - 1
@onready var Y_MAX: int = tile_map.y - 1

@onready var visible_hp_label: bool = false



func _ready() -> void:
	pass


func _process(delta: float) -> void:
	pass


func init_cell_tile_map() -> void:
	# 各セルをランダムで生成
	CellManager.create_cells(X_MAX, Y_MAX)

	self._create_cell_map()
	
	self._connect_change_cell()
	
	self._setting_surroudings()


func _create_cell_map():
	# init layer color
	var color_config = ConfigManager.get_config("color")
	for kind in color_config:
		set_layer_modulate(kind, color_config[kind])
	
	# create cell func
	var f = func(coords:Vector2i, cell:Cell):
		_add_cell(cell.kind, coords)
		var hp_label = hp_label_scene.instantiate()
		# 15づつずらしているのはセルの中心に表示させるため
		hp_label.position = map_to_local(coords) - Vector2(15, 15) 
		# TODO 無名関数でやっているが、hp_labelにscriptいれたほうがいいかも
		cell.hp_changed.connect(func(hp:int):hp_label.text=str(hp))
		if not self.visible_hp_label:
			hp_label.visible = false
		add_child(hp_label)

	CellManager.foreach_cells(f)

func _connect_change_cell():
	var f = func(coords:Vector2i, cell:Cell):
		var replace_func = func(old_kind:Common.Kind, new_kind:Common.Kind):
			_replace_cell(old_kind, new_kind, coords)
		cell.cell_changed.connect(replace_func)

	CellManager.foreach_cells(f)

func _setting_surroudings():
	var f = func(coords:Vector2i, cell:Cell):
		var surroudings = _get_surroudings(coords)
		CellManager.connect_influence(coords.x, coords.y, surroudings)

	CellManager.foreach_cells(f)


# セルを生成します
func _add_cell(layer: int, coords: Vector2i) -> void:
	set_cell(layer, coords, 0, Vector2i(0, 0))

# セルを置き換えます
func _replace_cell(old_layer: int, new_layer: int, coords: Vector2i) -> void:
	erase_cell(old_layer, coords)
	set_cell(new_layer, coords, 0, Vector2i(0, 0))

func _get_surroudings(coords:Vector2i) -> Array[Vector2i]:
	var ret:Array[Vector2i] = []
	var surroudings = get_surrounding_cells(coords)
	for s in surroudings:
		if 0 <= s.x and s.x < X_MAX:
			if 0 <= s.y and s.y < Y_MAX:
				ret.append(s)
	return ret

func change_visible_hp_label(is_visible:bool) -> void:
	self.visible_hp_label = is_visible
	for n in get_children():
		n.visible = is_visible
	
func clear_cell_tile_map() -> void:
	# セルをすべてクリア
	clear()
	# HPラベルもクリア
	for n in get_children():
		n.queue_free()
