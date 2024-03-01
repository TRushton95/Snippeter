@tool
extends PanelContainer
class_name Listing

signal copy_button_pressed(snippet_name: String)
signal delete_button_pressed(snippet_name: String)
signal edit_button_pressed(snippet_name: String)

@onready var _label : Label = $MarginContainer/Label
@onready var _anim_player : AnimationPlayer = $AnimationPlayer
@onready var _listing_copy_button : Button = $ListingCopyButton


func _on_listing_copy_button_pressed() -> void:
	copy_button_pressed.emit(_label.text)
	_anim_player.play("copy")


func _on_copy_button_pressed() -> void:
	copy_button_pressed.emit(_label.text)
	_anim_player.play("copy")


func _on_delete_button_pressed() -> void:
	delete_button_pressed.emit(_label.text)


func _on_edit_button_pressed() -> void:
	edit_button_pressed.emit(_label.text)


func setup(snippet_name: String) -> void:
	_label.text = snippet_name


func _on_listing_copy_button_mouse_entered() -> void:
	_listing_copy_button.modulate.a = 0.5


func _on_listing_copy_button_mouse_exited() -> void:
	_listing_copy_button.modulate.a = 0.0
