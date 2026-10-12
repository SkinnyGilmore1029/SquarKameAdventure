extends CharacterBody2D



func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is MainKame:
		if self.name == "Lizard":
			print("I have Key one")
		elif self.name == "Lizard2":
			print("I have Key two")
		else:
			print("My name is -->  %s" % self.name)

