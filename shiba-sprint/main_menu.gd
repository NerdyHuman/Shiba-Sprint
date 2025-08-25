extends Control

@onready var settings_panel = $SettingsPanel
@onready var start_button = $StartButton
@onready var settings_button = $SettingsButton
@onready var exit_button = $ExitButton

func _ready():
	settings_panel.visible = false

func _on_settings_button_pressed():
	settings_panel.visible = true
	start_button.visible = false
	settings_button.visible = false
	exit_button.visible = false

func _on_back_pressed():
	settings_panel.visible = false
	start_button.visible = true
	settings_button.visible = true
	exit_button.visible = true
