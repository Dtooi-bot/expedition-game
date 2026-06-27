// obj_npc_joseph
// Draw Event
// Буква E рисуется над головой персонажа,
// а не в фиксированной точке около origin.

draw_self();

if (show_hint) {
    var hint_offset_y = 10;

    var hint_x = x;
    var hint_y = y - sprite_get_yoffset(sprite_index) * abs(image_yscale) - hint_offset_y;

    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_set_valign(fa_bottom);

    draw_text(hint_x, hint_y, "E");

    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}
