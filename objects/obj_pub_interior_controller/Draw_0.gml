// obj_pub_interior_controller
// Draw Event
// Рисует статичный интерьер паба.

var bg_sprite = asset_get_index("spr_pub_interior");

if (bg_sprite == -1) {
    draw_set_color(c_black);
    draw_rectangle(0, 0, room_width, room_height, false);

    draw_set_color(c_white);
    draw_text(32, 32, "Нет спрайта spr_pub_interior");
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
