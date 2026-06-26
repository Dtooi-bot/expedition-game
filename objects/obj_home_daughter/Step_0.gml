// obj_home_daughter_Step.txt
// Step Event
// Полная версия Step для obj_home_daughter.
// Проверяет расстояние до игрока и открывает диалог по E.

show_hint = false;

if (instance_exists(obj_player)) {
    var player_near = point_distance(x, y, obj_player.x, obj_player.y) <= interaction_distance;

    if (player_near) {
        show_hint = true;

        if (keyboard_check_pressed(ord("E"))) {
            show_message(
                npc_name + "\n\n"
                + dialogue_text + "\n\n"
                + "Здоровье: " + string(global.daughter_health) + "\n"
                + "Доверие: " + string(global.daughter_trust) + "\n"
                + "Лояльность: " + string(global.daughter_loyalty)
            );
        }
    }
}
