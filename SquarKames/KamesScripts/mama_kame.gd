class_name MamaKame
extends StaticBody2D

var egg_list: Array = []

func _ready() -> void:
	pass


#body_enetered signal
func open_text_box(body: Node2D) -> void:
	if body is MainKame:
		%MamaText.visible = true


#body exited signal
func close_text_box(body: Node2D) -> void:
	if body is MainKame:
		%MamaText.visible = false


func have_all_eggs() -> void:
	if egg_list.size() == 5:
		pass