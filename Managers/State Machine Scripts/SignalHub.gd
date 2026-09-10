class_name Signals
extends Node

#for player hub
signal one_up_collected(new_count)

#for player hub
signal subtract_one_up(new_count)

##for PlayerGlobals.players_lives
signal one_up_global


signal key_collected(new_count)

signal key_used(new_count)

signal player_died

signal check_point(parent_pos)

