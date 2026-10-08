class_name Signals
extends Node



#-----------------PlayerSignals-----------------------
signal one_up_collected(new_count)
signal subtract_one_up(new_count)
signal one_up_global
signal player_died

#-----------------Collectables------------------------
signal key_collected(new_count)
signal change_key_count(new_count)
signal key_used


#-----------------LevelSignals------------------------
signal check_point(parent_pos)
signal button_pushed_level2(button_node,parent_node)
signal start_hot_bar(value)
signal stop_hot_bar
signal entered_puddle
signal exited_puddle



#-----------------MenuSignals-------------------------
signal changed_levels(new_level)
signal change_level_number(new_level)

#-----------------TextBoxSignals----------------------
signal has_fruit(the_taker: StaticBody2D)
signal giving_offer


