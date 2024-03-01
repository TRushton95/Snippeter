extends PanelContainer

signal selected

@onready var _button : Button = $Button


func _on_button_pressed() -> void:
	selected.emit()


func setup(text: String) -> void:
	_button.text = text


func get_snippet_name() -> String:
	return _button.text
