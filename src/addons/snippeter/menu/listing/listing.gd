@tool
extends PanelContainer
class_name Snippeter_Listing

signal copy_button_pressed(snippet_name: String)
signal delete_button_pressed(snippet_name: String)
signal edit_button_pressed(snippet_name: String)

@onready var _listing_button : Button = $HBoxContainer/ListingButton
@onready var _anim_player : AnimationPlayer = $AnimationPlayer


func _on_listing_button_pressed() -> void:
	copy_button_pressed.emit(_listing_button.text)
	_anim_player.play("copy")


func _on_copy_button_pressed() -> void:
	copy_button_pressed.emit(_listing_button.text)
	_anim_player.play("copy")


func _on_delete_button_pressed() -> void:
	delete_button_pressed.emit(_listing_button.text)


func _on_edit_button_pressed() -> void:
	edit_button_pressed.emit(_listing_button.text)


func setup(snippet_name: String) -> void:
	_listing_button.text = snippet_name
