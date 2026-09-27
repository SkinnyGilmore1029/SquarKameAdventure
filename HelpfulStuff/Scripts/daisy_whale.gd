extends StaticBody2D

#this is attached to a staticBody2d not my main kame.

@onready var message_label: Label = $TextBox/MessageLabel

func _ready() -> void:
	SignalHub.has_fruit.connect(got_strawberry)

func open_text_box(body: Node2D) -> void:
	if body is MainKame:
		%TextBox.visible = true


func close_text_box(body: Node2D) -> void:
	if body is MainKame:
		%TextBox.visible = false


func got_strawberry(the_whale: StaticBody2D) -> void:
	if the_whale != self:
		return
	message_label.text = "Thank You for the strawberry!"