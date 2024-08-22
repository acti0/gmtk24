class_name Menu extends Control

signal opened
signal closed

## Show menu
func open() -> void:
	show()
	opened.emit()

## Hide menu
func close() -> void:
	hide()
	closed.emit()
