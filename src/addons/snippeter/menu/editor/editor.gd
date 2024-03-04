@tool
extends PopupPanel

signal save_button_pressed(snippet: Snippet)
signal close_button_presssed

const CREATE_WINDOW_NAME : String = "Create a Snippet"
const EDIT_WINDOW_NAME : String = "Edit a Snippet"

const Snippet = preload("res://addons/snippeter/shared/snippet.gd")

var _is_edit_mode : bool = false

@onready var _code_edit : CodeEdit = $VBoxContainer/MarginContainer/CodeEdit
@onready var _empty_name_dialog : AcceptDialog = $EmptyNameDialog
@onready var _existing_name_dialog : AcceptDialog = $ExistingNameDialog
@onready var _snippet_name_line_edit : LineEdit = $VBoxContainer/LineEdit


func _on_save_button_pressed() -> void:
	if _snippet_name_line_edit.text == "":
		_empty_name_dialog.show()
		return
	
	var snippet = Snippet.new(_snippet_name_line_edit.text, _code_edit.text)
	save_button_pressed.emit(snippet)


func _on_close_button_pressed() -> void:
	close_button_presssed.emit()


func clear() -> void:
	_snippet_name_line_edit.clear()
	_code_edit.clear()
	_set_edit_mode(false)


func populate(snippet: Snippet) -> void:
	_snippet_name_line_edit.text = snippet.get_name()
	_code_edit.text = snippet.get_data()
	_set_edit_mode(true)


func show_existing_name_dialog() -> void:
	_existing_name_dialog.show()


func is_edit_mode() -> bool:
	return _is_edit_mode


func _set_edit_mode(is_edit: bool) -> void:
	_snippet_name_line_edit.editable = !is_edit
	_is_edit_mode = is_edit
	title = EDIT_WINDOW_NAME if is_edit else CREATE_WINDOW_NAME
