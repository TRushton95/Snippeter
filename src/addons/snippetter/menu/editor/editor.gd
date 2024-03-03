@tool
extends PopupPanel
class_name Snippetter_Editor

signal save_button_pressed(snippet: Snippetter_Snippet)
signal close_button_presssed

const CREATE_WINDOW_NAME : String = "Create a Snippet"
const EDIT_WINDOW_NAME : String = "Edit a Snippet"

@onready var _snippet_name_line_edit : LineEdit = $VBoxContainer/LineEdit
@onready var _code_edit : CodeEdit = $VBoxContainer/MarginContainer/CodeEdit


func _on_save_button_pressed() -> void:
	var snippet = Snippetter_Snippet.new(_snippet_name_line_edit.text, _code_edit.text)
	save_button_pressed.emit(snippet)


func _on_close_button_pressed() -> void:
	close_button_presssed.emit()


func clear() -> void:
	_snippet_name_line_edit.clear()
	_code_edit.clear()
	_snippet_name_line_edit.editable = true
	title = CREATE_WINDOW_NAME


func populate(snippet: Snippetter_Snippet) -> void:
	_snippet_name_line_edit.text = snippet.get_name()
	_code_edit.text = snippet.get_data()
	_snippet_name_line_edit.editable = false
	title = EDIT_WINDOW_NAME
