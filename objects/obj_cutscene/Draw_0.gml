// obj_cutscene_Draw.txt
// Draw GUI Event
// Полная версия для obj_cutscene.
// Рисует диалог, выбор и текущие показатели семьи.

var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();

draw_set_alpha(0.85);
draw_set_color(c_black);
draw_rectangle(32, gui_h - 230, gui_w - 32, gui_h - 32, false);
draw_set_alpha(1);

draw_set_color(c_white);

draw_text(56, gui_h - 215, "Семья");
draw_text(56, gui_h - 195, "Жена: здоровье " + string(global.wife_health) + " | доверие " + string(global.wife_trust) + " | лояльность " + string(global.wife_loyalty));
draw_text(56, gui_h - 175, "Дочь: здоровье " + string(global.daughter_health) + " | доверие " + string(global.daughter_trust) + " | лояльность " + string(global.daughter_loyalty));

if (dialogue_open) {
    draw_text(56, gui_h - 140, speaker);
    draw_text(56, gui_h - 110, dialogue_text);
    draw_text(56, gui_h - 65, "Space / Enter - дальше");
}

if (choice_open) {
    draw_text(56, gui_h - 140, "Перед отплытием нужно решить, куда пойдут накопленные деньги.");

    if (choice_index == 0) {
        draw_text(56, gui_h - 105, "> Оставить больше семье");
        draw_text(56, gui_h - 80, "  Вложить больше в экспедицию");
    }
    else {
        draw_text(56, gui_h - 105, "  Оставить больше семье");
        draw_text(56, gui_h - 80, "> Вложить больше в экспедицию");
    }

    draw_text(56, gui_h - 50, "W/S - выбрать, Enter - подтвердить");
}
