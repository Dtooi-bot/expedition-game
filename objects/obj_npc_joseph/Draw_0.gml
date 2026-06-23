// Draw Event

draw_self();

if (instance_exists(obj_player)) {
    var dist_to_player = point_distance(x, y, obj_player.x, obj_player.y);

    if (dist_to_player <= interaction_distance) {
        draw_text(x - 8, y - 36, "E");
    }
}