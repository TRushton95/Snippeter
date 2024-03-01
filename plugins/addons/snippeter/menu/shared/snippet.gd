extends Object
class_name Snippet

var _name: String
var _data: String


func _init(name: String, data: String) -> void:
	self._name = name
	self._data = data


func get_name() -> String:
	return _name


func get_data() -> String:
	return _data
