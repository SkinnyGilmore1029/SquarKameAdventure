class_name Signals
extends Node

#for player hub
signal one_up_collected(new_count)

#for player hub
signal subtract_one_up(new_count)

##for PlayerGlobals.players_lives
signal one_up_global


signal key_collected(new_count)
signal change_key_count(new_count)

signal key_used

signal player_died

signal check_point(parent_pos)

signal changed_levels(new_level)
signal change_level_number(new_level)

signal button_pushed_level2(button_node,parent_node)

