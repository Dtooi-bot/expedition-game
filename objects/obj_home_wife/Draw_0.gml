// obj_home_wife_Draw.txt
// Draw Event
// Полная версия Draw для obj_home_wife.
// Рисует персонажа и подсказку E рядом с ним.

draw_self();

if (show_hint) {
    draw_set_color(c_white);
    draw_text(x - 8, y - 48, "E");
}
