// obj_cutscene_family_Draw_GUI.txt
// Draw GUI Event
// Рисует диалоговое окно и окно выбора.

var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();

draw_set_alpha(0.85);
draw_set_color(c_black);
draw_rectangle(32, gui_h - 170, gui_w - 32, gui_h - 32, false);
draw_set_alpha(1);

draw_set_color(c_white);

if (dialogue_open) {
    draw_text(56, gui_h - 150, speaker);
    draw_text(56, gui_h - 115, dialogue_text);
    draw_text(56, gui_h - 65, "Space / Enter - дальше");
}

if (choice_open) {
    draw_text(56, gui_h - 150, "На столе лежит 100 золотых.");

    if (choice_index == 0) {
        draw_text(56, gui_h - 110, "> Оставить семье");
        draw_text(56, gui_h - 85, "  Забрать в экспедицию");
    }
    else {
        draw_text(56, gui_h - 110, "  Оставить семье");
        draw_text(56, gui_h - 85, "> Забрать в экспедицию");
    }

    draw_text(56, gui_h - 50, "W/S - выбрать, Enter - подтвердить");
}
