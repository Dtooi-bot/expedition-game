// obj_pub_interior_controller
// Draw Event
// Рисует статичный интерьер паба.
// Используем прямую ссылку на спрайт, а не asset_get_index().

var bg_sprite = spr_pub_interior;

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
