// obj_game
// Draw GUI Event
// Интерфейс паузы.

scr_game_state_init();

if (global.game_state != GameState.PAUSE) {
    exit;
}

var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();

draw_set_alpha(0.65);
draw_set_color(c_black);
draw_rectangle(0, 0, gui_w, gui_h, false);
draw_set_alpha(1);

draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(c_white);

draw_text(gui_w * 0.5, gui_h * 0.5 - 20, "ПАУЗА");
draw_text(gui_w * 0.5, gui_h * 0.5 + 20, "Escape - продолжить");

draw_set_halign(fa_left);
draw_set_valign(fa_top);
