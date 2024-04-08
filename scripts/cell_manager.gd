extends RefCounted

class_name CellManager

signal counted_cell(count_dict:Dictionary)
signal erased_cells()

# TODO staticやめたい　シングルトンにするか？
# 参考
#  
static var _cell_data:Dictionary

static var _size_x:int
static var _size_y:int

static func create_cells(size_x:int, size_y:int) -> void:
	if _cell_data == null:
		_cell_data = {}
		
	_size_x = size_x
	_size_y = size_y
	for x in _size_x:
		for y in _size_y:
			# ランダムにセルを生成
			_cell_data[Vector2i(x, y)] = Cell.new(randi() % Common.Kind.size())

static func get_cell(x:int, y:int) -> Cell:
	return _cell_data[Vector2i(x, y)]
	
static func get_cell_by_coords(coords:Vector2i) -> Cell:
	return _cell_data[coords]
	
static func foreach_cells(func_ref) -> void:
	for coords:Vector2i in _cell_data:
		func_ref.call(coords, _cell_data[coords])
	
static func connect_influence(x:int, y:int, observers:Array[Vector2i]) -> void:
	var cell = get_cell(x, y)
	for o:Vector2i in observers:
		cell.influenced.connect(get_cell_by_coords(o).is_influenced)

static func influence() -> void:
	for coords:Vector2i in _cell_data:
		_cell_data[coords].influence()

static func change() -> void:
	for coords:Vector2i in _cell_data:
		_cell_data[coords].change()

static func refresh_hp() -> void:
	for coords:Vector2i in _cell_data:
		_cell_data[coords].refresh_hp()


static func count_cells() -> Dictionary:
	var count_dict:Dictionary = {\
			Common.Kind.ROCK:0, \
			Common.Kind.SCISSORS:0, \
			Common.Kind.PAPER:0, \
			Common.Kind.NONE:0 \
	}
	for coords:Vector2i in _cell_data:
		var cell:Cell = _cell_data[coords]
		count_dict[cell.kind] = count_dict[cell.kind] + 1
	
	#counted_cell.emit(count_dict) # TODO staticなのでsignal発火できない
	return count_dict

static func erase_cells() -> void:
	_cell_data.clear() # cellはRefCountedなので明示的にqueue_free呼ばなくていい
	
	#erased_cell.emit() # TODO staticなのでsignal発火できない
