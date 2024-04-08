extends Node

class_name ConfigManager

# データは非static(dynamic)変数にする
var config:Dictionary
var config_default:Dictionary

# シングルトン用
static var _inst:ConfigManager = null

static func _secure_inst() -> void:
	if ConfigManager._inst == null:
		ConfigManager._inst = ConfigManager.new()
		var scene_tree: SceneTree = Engine.get_main_loop() as SceneTree
		var root: Window = scene_tree.root
		root.add_child.call_deferred(ConfigManager._inst)

func _init() -> void:
	print("config_manager : _init")
	config_default = {
		generation_speed = 0.5,
		damage = {
			Common.Kind.ROCK:10,
			Common.Kind.SCISSORS:10,
			Common.Kind.PAPER:10,
			Common.Kind.NONE:10
		},
		hp = {
			Common.Kind.ROCK:100,
			Common.Kind.SCISSORS:100,
			Common.Kind.PAPER:100,
			Common.Kind.NONE:10
		},
		heal = {
			Common.Kind.ROCK:1,
			Common.Kind.SCISSORS:1,
			Common.Kind.PAPER:1,
			Common.Kind.NONE:1
		},
		color = {
			Common.Kind.ROCK:Color8(255, 182, 193, 255), # lightpink
			Common.Kind.SCISSORS:Color8(135, 206, 250, 255), # lightskyblue
			Common.Kind.PAPER:Color8(255, 255, 224, 255), # lightyellow
			Common.Kind.NONE:Color8(211, 211, 211, 255) # lightgray
		},
	}
	
	config = config_default.duplicate(true)

static func get_config(which: String) -> Variant:
	ConfigManager._secure_inst()
	return ConfigManager._inst.config[which]

static func get_config_default(which: String) -> Variant:
	ConfigManager._secure_inst()
	return ConfigManager._inst.config_default[which]

static func get_config_value(which: String, kind: Common.Kind) -> Variant:
	ConfigManager._secure_inst()
	return ConfigManager._inst.config[which][kind]

static func get_config_default_value(which: String, kind: Common.Kind) -> Variant:
	ConfigManager._secure_inst()
	return ConfigManager._inst.config_default[which][kind]

static func change_config(which: String, kind: Common.Kind, value) -> void:
	ConfigManager._secure_inst()
	print("config_manager#change_config : " + str(which) + ", " + Common.kind_string(kind) + ", " + str(value))
	ConfigManager._inst.config[which][kind] = value

static func change_config_single(which: String, value) -> void:
	ConfigManager._secure_inst()
	ConfigManager._inst.config[which] = value
