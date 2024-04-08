extends CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_init_setting()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_close_button_pressed() -> void:
	visible = false

func _on_config_spin_edit_value_changed(value: float, which: String, kind: Common.Kind) -> void:
	ConfigManager.change_config(which, kind, int(value))

func _on_config_reset_pressed(target: SpinBox, which: String, kind: Common.Kind) -> void:
	target.value = float(ConfigManager.get_config_default_value(which, kind))


func _on_config_color_picker_button_color_changed(color: Color, kind: Common.Kind, fontAwesome) -> void:
	fontAwesome["theme_override_colors/font_color"] = color
	ConfigManager.change_config("color", kind, color)


func _on_config_color_reset_pressed(pickerButton: ColorPickerButton, kind: Common.Kind, fontAwesome) -> void:
	var color = ConfigManager.get_config_default_value("color", kind)
	pickerButton.color = color
	# color_changedは上記で変更しても自動で呼び出されないので、明示的に呼ぶ
	pickerButton.color_changed.emit(color)
	fontAwesome["theme_override_colors/font_color"] = color


func _on_generation_config_speed_edit_value_changed(value: float) -> void:
	ConfigManager.change_config_single("generation_speed", value)


func _on_generation_config_speed_reset_pressed() -> void:
	%GenerationConfigSpeedEdit.value = ConfigManager.get_config_default("generation_speed")



func _init_setting() -> void:
	
	%GenerationConfigSpeedEdit.value = ConfigManager.get_config("generation_speed")
	
	# Rock
	%RockFontAwesome["theme_override_colors/font_color"] = ConfigManager.get_config_value("color", Common.Kind.ROCK)
	
	%RockConfigColorPickerButton.color = ConfigManager.get_config_value("color", Common.Kind.ROCK)
	%RockConfigColorPickerButton.color_changed.connect(_on_config_color_picker_button_color_changed.bind(Common.Kind.ROCK, %RockFontAwesome))
	%RockConfigColorReset.pressed.connect(_on_config_color_reset_pressed.bind(%RockConfigColorPickerButton, Common.Kind.ROCK, %RockFontAwesome))

	%RockConfigHPEdit.value = float(ConfigManager.get_config_value("hp", Common.Kind.ROCK))
	%RockConfigHPEdit.value_changed.connect(_on_config_spin_edit_value_changed.bind("hp", Common.Kind.ROCK))
	%RockConfigHPReset.pressed.connect(_on_config_reset_pressed.bind(%RockConfigHPEdit, "hp", Common.Kind.ROCK))

	%RockConfigDamageEdit.value = float(ConfigManager.get_config_value("damage", Common.Kind.ROCK))
	%RockConfigDamageEdit.value_changed.connect(_on_config_spin_edit_value_changed.bind("damage", Common.Kind.ROCK))
	%RockConfigDamageReset.pressed.connect(_on_config_reset_pressed.bind(%RockConfigDamageEdit, "damage", Common.Kind.ROCK))

	%RockConfigHealEdit.value = float(ConfigManager.get_config_value("heal", Common.Kind.ROCK))
	%RockConfigHealEdit.value_changed.connect(_on_config_spin_edit_value_changed.bind("heal", Common.Kind.ROCK))
	%RockConfigHealReset.pressed.connect(_on_config_reset_pressed.bind(%RockConfigHealEdit, "heal", Common.Kind.ROCK))
	
	# Scissors
	%ScissorsFontAwesome["theme_override_colors/font_color"] = ConfigManager.get_config_value("color", Common.Kind.SCISSORS)
	
	%ScissorsConfigColorPickerButton.color = ConfigManager.get_config_value("color", Common.Kind.SCISSORS)
	%ScissorsConfigColorPickerButton.color_changed.connect(_on_config_color_picker_button_color_changed.bind(Common.Kind.SCISSORS, %ScissorsFontAwesome))
	%ScissorsConfigColorReset.pressed.connect(_on_config_color_reset_pressed.bind(%ScissorsConfigColorPickerButton, Common.Kind.SCISSORS, %ScissorsFontAwesome))

	%ScissorsConfigHPEdit.value = float(ConfigManager.get_config_value("hp", Common.Kind.SCISSORS))
	%ScissorsConfigHPEdit.value_changed.connect(_on_config_spin_edit_value_changed.bind("hp", Common.Kind.SCISSORS))
	%ScissorsConfigHPReset.pressed.connect(_on_config_reset_pressed.bind(%ScissorsConfigHPEdit, "hp", Common.Kind.SCISSORS))

	%ScissorsConfigDamageEdit.value = float(ConfigManager.get_config_value("damage", Common.Kind.SCISSORS))
	%ScissorsConfigDamageEdit.value_changed.connect(_on_config_spin_edit_value_changed.bind("damage", Common.Kind.SCISSORS))
	%ScissorsConfigDamageReset.pressed.connect(_on_config_reset_pressed.bind(%ScissorsConfigDamageEdit, "damage", Common.Kind.SCISSORS))

	%ScissorsConfigHealEdit.value = float(ConfigManager.get_config_value("heal", Common.Kind.SCISSORS))
	%ScissorsConfigHealEdit.value_changed.connect(_on_config_spin_edit_value_changed.bind("heal", Common.Kind.SCISSORS))
	%ScissorsConfigHealReset.pressed.connect(_on_config_reset_pressed.bind(%ScissorsConfigHealEdit, "heal", Common.Kind.SCISSORS))
	
	# Paper
	%PaperFontAwesome["theme_override_colors/font_color"] = ConfigManager.get_config_value("color", Common.Kind.PAPER)
	
	%PaperConfigColorPickerButton.color = ConfigManager.get_config_value("color", Common.Kind.PAPER)
	%PaperConfigColorPickerButton.color_changed.connect(_on_config_color_picker_button_color_changed.bind(Common.Kind.PAPER, %PaperFontAwesome))
	%PaperConfigColorReset.pressed.connect(_on_config_color_reset_pressed.bind(%PaperConfigColorPickerButton, Common.Kind.PAPER, %PaperFontAwesome))

	%PaperConfigHPEdit.value = float(ConfigManager.get_config_value("hp", Common.Kind.PAPER))
	%PaperConfigHPEdit.value_changed.connect(_on_config_spin_edit_value_changed.bind("hp", Common.Kind.PAPER))
	%PaperConfigHPReset.pressed.connect(_on_config_reset_pressed.bind(%PaperConfigHPEdit, "hp", Common.Kind.PAPER))

	%PaperConfigDamageEdit.value = float(ConfigManager.get_config_value("damage", Common.Kind.PAPER))
	%PaperConfigDamageEdit.value_changed.connect(_on_config_spin_edit_value_changed.bind("damage", Common.Kind.PAPER))
	%PaperConfigDamageReset.pressed.connect(_on_config_reset_pressed.bind(%PaperConfigDamageEdit, "damage", Common.Kind.PAPER))

	%PaperConfigHealEdit.value = float(ConfigManager.get_config_value("heal", Common.Kind.PAPER))
	%PaperConfigHealEdit.value_changed.connect(_on_config_spin_edit_value_changed.bind("heal", Common.Kind.PAPER))
	%PaperConfigHealReset.pressed.connect(_on_config_reset_pressed.bind(%PaperConfigHealEdit, "heal", Common.Kind.PAPER))
	
	# None
	%NoneFontAwesome["theme_override_colors/font_color"] = ConfigManager.get_config_value("color", Common.Kind.NONE)
	
	%NoneConfigColorPickerButton.color = ConfigManager.get_config_value("color", Common.Kind.NONE)
	%NoneConfigColorPickerButton.color_changed.connect(_on_config_color_picker_button_color_changed.bind(Common.Kind.NONE, %NoneFontAwesome))
	%NoneConfigColorReset.pressed.connect(_on_config_color_reset_pressed.bind(%NoneConfigColorPickerButton, Common.Kind.NONE, %NoneFontAwesome))

	%NoneConfigHPEdit.value = float(ConfigManager.get_config_value("hp", Common.Kind.NONE))
	%NoneConfigHPEdit.value_changed.connect(_on_config_spin_edit_value_changed.bind("hp", Common.Kind.NONE))
	%NoneConfigHPReset.pressed.connect(_on_config_reset_pressed.bind(%NoneConfigHPEdit, "hp", Common.Kind.NONE))

	%NoneConfigDamageEdit.value = float(ConfigManager.get_config_value("damage", Common.Kind.NONE))
	%NoneConfigDamageEdit.value_changed.connect(_on_config_spin_edit_value_changed.bind("damage", Common.Kind.NONE))
	%NoneConfigDamageReset.pressed.connect(_on_config_reset_pressed.bind(%NoneConfigDamageEdit, "damage", Common.Kind.NONE))

	%NoneConfigHealEdit.value = float(ConfigManager.get_config_value("heal", Common.Kind.NONE))
	%NoneConfigHealEdit.value_changed.connect(_on_config_spin_edit_value_changed.bind("heal", Common.Kind.NONE))
	%NoneConfigHealReset.pressed.connect(_on_config_reset_pressed.bind(%NoneConfigHealEdit, "heal", Common.Kind.NONE))
	

