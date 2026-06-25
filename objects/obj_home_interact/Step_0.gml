// obj_home_interact_Step.txt
// Step Event
// Проверяет, рядом ли игрок, и открывает текст по E.

show_hint = false;

if (instance_exists(obj_player)) {
    var dist_to_player = point_distance(x, y, obj_player.x, obj_player.y);

    if (dist_to_player <= interaction_distance) {
        show_hint = true;

        if (keyboard_check_pressed(ord("E"))) {
            show_message(interact_title + "\n\n" + interact_text);
        }
    }
}
