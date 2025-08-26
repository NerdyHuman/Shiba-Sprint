extends Control

@onready var start_button = $TextureRect/TextureRect2/StartButton
@onready var exit_button = $TextureRect/ExitButton
@onready var settings_panel = $TextureRect/settingsbutton/SettingsPanel
@onready var settings_button = $TextureRect/settingsbutton/SettingsPanel/OptionButton
@onready var volume_slider = $TextureRect/settingsbutton/SettingsPanel/HSlider
@onready var difficulty_input = $TextureRect/settingsbutton/SettingsPanel/TextEdit

func _ready():
	settings_panel.visible = false

	# Connect buttons
	start_button.pressed.connect(_on_start_pressed)
	exit_button.pressed.connect(_on_exit_pressed)
	settings_button.pressed.connect(_on_settingsbutton_pressed)  # Button press to toggle panel visibility

	# Connect slider
	volume_slider.value_changed.connect(_on_volume_changed)

	# Connect OptionButton signal for item selection
	settings_button.item_selected.connect(_on_option_selected)

func _on_start_pressed():
	print("Start Game pressed")
	# Replace with your scene loading code
	# get_tree().change_scene_to_file("res://YourGameScene.tscn")

func _on_exit_pressed():
	print("Exit pressed")
	get_tree().quit()

func _on_settingsbutton_pressed():
	settings_panel.visible = true

func _on_volume_changed(value):
	print("Volume set to: %s" % value)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear_to_db(value))

func _on_option_selected(index):
	print("OptionButton selected index: %d, text: %s" % [index, settings_button.get_item_text(index)])
	# You can perform actions based on selection here,
	# e.g. adjust difficulty or other settings depending on index

func get_difficulty():
	return difficulty_input.text.strip()
