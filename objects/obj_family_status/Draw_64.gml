// obj_family_status_Draw_GUI.txt
// Draw GUI Event
// Полная версия для obj_family_status.
// Показывает меню отношений только при нажатии I.

if (!family_menu_open) {
    exit;
}

if (!variable_global_exists("wife_health")) {
    scr_game_init();
}

var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();

var panel_x1 = 32;
var panel_y1 = 32;
var panel_x2 = 460;
var panel_y2 = 250;

draw_set_alpha(0.88);
draw_set_color(c_black);
draw_rectangle(panel_x1, panel_y1, panel_x2, panel_y2, false);
draw_set_alpha(1);

draw_set_color(c_white);

draw_text(panel_x1 + 24, panel_y1 + 20, "СЕМЬЯ");
draw_text(panel_x1 + 24, panel_y1 + 48, "I - закрыть меню");

draw_text(panel_x1 + 24, panel_y1 + 88, "Жена");
draw_text(panel_x1 + 44, panel_y1 + 112, "Здоровье: " + string(global.wife_health));
draw_text(panel_x1 + 44, panel_y1 + 136, "Доверие: " + string(global.wife_trust));
draw_text(panel_x1 + 44, panel_y1 + 160, "Лояльность: " + string(global.wife_loyalty));

draw_text(panel_x1 + 240, panel_y1 + 88, "Дочь");
draw_text(panel_x1 + 260, panel_y1 + 112, "Здоровье: " + string(global.daughter_health));
draw_text(panel_x1 + 260, panel_y1 + 136, "Доверие: " + string(global.daughter_trust));
draw_text(panel_x1 + 260, panel_y1 + 160, "Лояльность: " + string(global.daughter_loyalty));
