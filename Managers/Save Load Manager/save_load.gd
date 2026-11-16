class_name Save_LoadManager
extends Node

var save_data: Dictionary[String, int] = {"High Score" : 0}

var save_path: String = "user://savegame.json"

func save_game():
    save_data = {
        "High Score" : Points.high_score
    }
    var file = FileAccess.open(save_path, FileAccess.WRITE)

    if file:
        file.store_string(JSON.stringify(save_data, "\t", false))
        file.close()
    else:
        push_error("Unable to create new save file!")

func load_game():
    if not FileAccess.file_exists(save_path):
        return

    var file = FileAccess.open(save_path, FileAccess.READ)

    if file:
        var load_data = JSON.parse_string(file.get_as_text())
        file.close()

        if load_data is Dictionary:
            Points.high_score = load_data.get("High Score", 0)
    else:
        push_error("Can not open save file!")