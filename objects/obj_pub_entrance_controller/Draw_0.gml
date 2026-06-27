// obj_pub_entrance_controller
// Draw Event
// Рисует статичный фон улицы перед пабом.
// Обычный Draw используется, чтобы фон был позади игрока.

var bg_sprite = noone;

switch (current_stage) {
    case 0:
        bg_sprite = asset_get_index("spr_pub_street_idle");
        break;

    case 1:
        bg_sprite = asset_get_index("spr_pub_street_joseph_scene");
        break;

    case 2:
        bg_sprite = asset_get_index("spr_pub_street_open_door");
        break;
}

if (bg_sprite == -1 || bg_sprite == noone) {
    draw_set_color(c_black);
    draw_rectangle(0, 0, room_width, room_height, false);

    draw_set_color(c_white);
    draw_text(32, 32, "Нет спрайта улицы паба");
    exit;
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
