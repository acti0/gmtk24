class_name Menu extends Control

signal opened
signal closed

func open() -> void:
	show()
	opened.emit()

func close() -> void:
	hide()
	closed.emit()
