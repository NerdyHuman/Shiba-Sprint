extends Control

@onready var start_button = $TextureRect/TextureRect2/StartButton
@onready var exit_button = $TextureRect/ExitButton
@onready var settings_panel = $TextureRect/settingsbutton/SettingsPanel
@onready var settings_button = $TextureRect/settingsbutton/SettingsPanel/OptionButton
@onready var volume_slider = $TextureRect/settingsbutton/SettingsPanel/HSlider
@onready var difficulty_input = $TextureRect/settingsbutton/SettingsPanel/HSlider/TextEdit
@onready var hover_sound_player = $HoverSoundPlayer
@onready var bgm_player = $BGMPlayer
@onready var volume_toggle = $VolumeToggle

func _ready():
	# Hide panel by default
	settings_panel.visible = false
	
	# Play BGM at start
	bgm_player.play()

	# Connect button pressed signals
	start_button.pressed.connect(_on_start_pressed)
	exit_button.pressed.connect(_on_exit_pressed)
	settings_panel.pressed.connect(_on_settingsbutton_pressed)

	# Connect volume slider change
	volume_slider.value_changed.connect(_on_volume_changed)

	# Connect OptionButton selection signal
	settings_button.item_selected.connect(_on_option_selected)

	# Connect hover sounds for buttons
	start_button.connect("mouse_entered", Callable(self, "_play_hover_sound"))
	exit_button.connect("mouse_entered", Callable(self, "_play_hover_sound"))
	settings_panel.connect("mouse_entered", Callable(self, "_play_hover_sound"))

	# Connect volume toggle pressed to turn BGM on/off
	volume_toggle.button_pressed = true  # Start with volume ON

	volume_toggle.connect("toggled", Callable(self, "_on_volume_toggle_toggled"))

func _on_start_pressed():
	print("Start Game pressed")

func _on_exit_pressed():
	print("Exit pressed")
	get_tree().quit()

func _on_settingsbutton_pressed():
	# Toggle visibility on each press
	settings_panel.visible = !settings_panel.visible

func _on_volume_changed(value):
	print("Volume set to: %s" % value)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear_to_db(value))

func _on_option_selected(index):
	print("OptionButton selected index: %d, text: %s" % [index, settings_button.get_item_text(index)])

func get_difficulty():
	return difficulty_input.text.strip()

func _play_hover_sound():
	if hover_sound_player.playing:
		hover_sound_player.stop()
	hover_sound_player.play()

func _on_volume_toggle_toggled(button_pressed):
	if button_pressed:
		bgm_player.play()
	else:
		bgm_player.stop()
