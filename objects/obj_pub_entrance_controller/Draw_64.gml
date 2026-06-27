// obj_pub_entrance_controller
// Draw GUI Event
// Временная подпись, чтобы было понятно, что переход в паб сработал.

draw_set_font(fnt_ui_cyrillic);

var gui_w = display_get_gui_width();

draw_set_alpha(0.82);
draw_set_color(c_black);
draw_rectangle(24, 24, 460, 118, false);
draw_set_alpha(1);

draw_set_color(c_white);
draw_rectangle(24, 24, 460, 118, true);

draw_set_halign(fa_left);
draw_set_valign(fa_top);

draw_text(48, 42, "Вход у паба");
draw_text(48, 74, "Заглушка локации. Дальше добавим фон, NPC и вход внутрь.");
