extends HBoxContainer

func _ready() -> void:
    SaveLoad.load_game()
    %HighScorePointsLabel.text = str(get_current_high_score())

func get_current_high_score() -> int:
    return Points.high_score

