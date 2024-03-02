@tool
extends PanelContainer
class_name Snippetter_Editor

signal save_button_pressed(snippet: Snippetter_Snippet)
signal cancel_button_presssed

@onready var _snippet_name_line_edit : LineEdit = $MarginContainer/VBoxContainer/LineEdit
@onready var _code_edit : CodeEdit = $MarginContainer/VBoxContainer/MarginContainer/CodeEdit

var _is_edit : bool = false


func _on_save_button_pressed() -> void:
	var snippet = Snippetter_Snippet.new(_snippet_name_line_edit.text, _code_edit.text)
	save_button_pressed.emit(snippet)


func _on_cancel_button_pressed() -> void:
	cancel_button_presssed.emit()


func clear() -> void:
	_snippet_name_line_edit.clear()
	_code_edit.clear()
	_is_edit = true
	_snippet_name_line_edit.editable = true


func populate(snippet: Snippetter_Snippet) -> void:
	_snippet_name_line_edit.text = snippet.get_name()
	_code_edit.text = snippet.get_data()
	_is_edit = false
	_snippet_name_line_edit.editable = false
