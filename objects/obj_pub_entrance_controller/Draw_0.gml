// obj_pub_entrance_controller
// Draw Event
// Рисует статичный фон улицы перед пабом.
// Используем прямые ссылки на спрайты, а не asset_get_index().

var bg_sprite = spr_pub_street_idle;

switch (current_stage) {
    case 0:
        bg_sprite = spr_pub_street_idle;
        break;

    case 1:
        bg_sprite = spr_pub_street_joseph_scene;
        break;

    case 2:
        bg_sprite = spr_pub_street_open_door;
        break;
}

var sx = room_width / sprite_get_width(bg_sprite);
var sy = room_height / sprite_get_height(bg_sprite);

draw_set_color(c_white);
draw_sprite_ext(
    bg_sprite,
    0,
    0,
    0,
    sx,
    sy,
    0,
    c_white,
    1
);
