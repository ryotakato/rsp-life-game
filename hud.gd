extends CanvasLayer

signal changed_running(running:bool)
signal reseted()
signal displayed_config()
signal changed_hp_label_display(is_visible:bool)

var running:bool = false

func _ready() -> void:
	init_hud()

func init_hud() -> void:
	%RockFontAwesome["theme_override_colors/font_color"] = ConfigManager.get_config_value("color", Common.Kind.ROCK)
	%ScissorsFontAwesome["theme_override_colors/font_color"] = ConfigManager.get_config_value("color", Common.Kind.SCISSORS)
	%PaperFontAwesome["theme_override_colors/font_color"] = ConfigManager.get_config_value("color", Common.Kind.PAPER)


func _on_run_button_pressed() -> void:
	print("_on_run_button_pressed : " + str(running))
	if running:
		# when user pushed pause
		%PlayFontAwesome.visible = true
		%PauseFontAwesome.visible = false
	else :
		# when user pushed play
		%PlayFontAwesome.visible = false
		%PauseFontAwesome.visible = true
	
	running = not running
	changed_running.emit(running)


func _on_config_button_pressed() -> void:
	print("_on_config_button_pressed")
	displayed_config.emit()


func _on_reset_button_pressed() -> void:
	print("_on_reset_button_pressed")
	reseted.emit()

func change_count_text(count_dict:Dictionary) -> void:
	find_child("RockCountLabel").text = str(count_dict[Common.Kind.ROCK])
	find_child("ScissorsCountLabel").text = str(count_dict[Common.Kind.SCISSORS])
	find_child("PaperCountLabel").text = str(count_dict[Common.Kind.PAPER])


func _on_hp_label_check_box_toggled(toggled_on: bool) -> void:
	print("_on_hp_label_check_box_toggled")
	changed_hp_label_display.emit(toggled_on)
