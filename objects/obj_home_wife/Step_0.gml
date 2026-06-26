// obj_home_wife_Step.txt
// Step Event
// Полная версия Step для obj_home_wife.
// В диалоге больше не показываем параметры.

show_hint = false;

if (instance_exists(obj_player)) {
    var player_near = point_distance(x, y, obj_player.x, obj_player.y) <= interaction_distance;

    if (player_near) {
        show_hint = true;

        if (keyboard_check_pressed(ord("E"))) {
            if (!variable_global_exists("wife_health")) {
                scr_game_init();
            }

            show_message(npc_name + "\n\n" + dialogue_text);
        }
    }
}
