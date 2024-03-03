@tool
extends PanelContainer

signal selected

@onready var _anim_player : AnimationPlayer = $AnimationPlayer
@onready var _button : Button = $Button


func _on_button_pressed() -> void:
	_anim_player.play("copy")
	selected.emit()


func setup(text: String) -> void:
	_button.text = text


func get_snippet_name() -> String:
	return _button.text
