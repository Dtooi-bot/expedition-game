// obj_cutscene_Draw_GUI.txt
// Draw GUI Event
// Полная версия для obj_cutscene.
// В диалоговом окне параметры семьи не показываем.
// Параметры открываются отдельно через меню на I.

var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();

draw_set_alpha(0.85);
draw_set_color(c_black);
draw_rectangle(32, gui_h - 180, gui_w - 32, gui_h - 32, false);
draw_set_alpha(1);

draw_set_color(c_white);

if (dialogue_open) {
    draw_text(56, gui_h - 150, speaker);
    draw_text(56, gui_h - 115, dialogue_text);
    draw_text(56, gui_h - 65, "Space / Enter - дальше");
}

if (choice_open) {
    draw_text(56, gui_h - 150, "Перед отплытием нужно решить, куда пойдут накопленные деньги.");

    if (choice_index == 0) {
        draw_text(56, gui_h - 110, "> Оставить больше семье");
        draw_text(56, gui_h - 85, "  Вложить больше в экспедицию");
    }
    else {
        draw_text(56, gui_h - 110, "  Оставить больше семье");
        draw_text(56, gui_h - 85, "> Вложить больше в экспедицию");
    }

    draw_text(56, gui_h - 50, "W/S - выбрать, Enter - подтвердить");
}

draw_text(56, 24, "I - отношения семьи");
