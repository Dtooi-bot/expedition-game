// obj_home_interact_Step.txt
// Step Event
// Полная версия Step для obj_home_interact.
// Работает не по центру объекта, а по прямоугольной зоне вокруг предмета.

show_hint = false;

if (instance_exists(obj_player)) {
    var check_left = bbox_left - interaction_distance;
    var check_top = bbox_top - interaction_distance;
    var check_right = bbox_right + interaction_distance;
    var check_bottom = bbox_bottom + interaction_distance;

    var player_near = rectangle_in_rectangle(
        obj_player.bbox_left,
        obj_player.bbox_top,
        obj_player.bbox_right,
        obj_player.bbox_bottom,
        check_left,
        check_top,
        check_right,
        check_bottom
    );

    if (player_near) {
        show_hint = true;

        if (keyboard_check_pressed(ord("E"))) {
            show_message(interact_title + "\n\n" + interact_text);
        }
    }
}
