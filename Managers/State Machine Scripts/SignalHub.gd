class_name Signals
extends Node



#-----------------PlayerSignals-----------------------
signal one_up_collected(new_count: int)
signal subtract_one_up(new_count: int)
signal one_up_global
signal player_died
signal reset_heat
signal update_current_score(value: int)
signal points_collected(value: int)
signal update_high_score(value: int)

#-----------------Collectables------------------------
signal key_collected(new_count: int)
signal change_key_count(new_count: int)
signal key_used



#-----------------LevelSignals------------------------
signal check_point(parent_pos: Vector2)
signal button_pushed_level2(button_node: Node, parent_node: Node)
signal button_pushed_level5(button_node: Node, parent_node: Node)
signal start_hot_bar(value: float)
signal stop_hot_bar
signal entered_puddle
signal exited_puddle
signal tornado_spawned
signal tornado_despawned
signal collected_fly(fly_name: String)
signal can_move_lizard


#-----------------MenuSignals-------------------------
signal changed_levels(new_level: int)
signal change_level_number(new_level: int)

#-----------------TextBoxSignals----------------------
signal has_fruit(the_taker: StaticBody2D)
signal giving_offer

#-----------------TransitionSignals-------------------
signal just_started_level
signal level_completed
signal show_paused_options
signal hide_paused_options
signal show_pause_menu
signal hide_pause_menu
signal focus_volume_slider
signal focus_continue_button

#-----------------PinSignals--------------------------
signal unpin_joint
