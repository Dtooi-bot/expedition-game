// Step Event

if (instance_exists(obj_player)) {
    var dist_to_player = point_distance(x, y, obj_player.x, obj_player.y);

    if (dist_to_player <= interaction_distance) {
        if (keyboard_check_pressed(ord("E"))) {
            show_message(dialogue_text);
        }
    }
}