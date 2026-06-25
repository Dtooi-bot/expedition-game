// obj_home_interact_Draw.txt
// Draw Event
// Интерактивная зона сама невидимая, но рядом с игроком показывает подсказку E.

if (show_hint) {
    draw_set_color(c_white);
    draw_text(x - 8, y - 32, "E");
}
