// obj_pub_entrance_controller
// Draw GUI Event
// Рисует подсказки E и локальное затемнение.

draw_set_font(fnt_ui_cyrillic);

var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();


// --------------------------------------------------
// ПОДСКАЗКИ
// --------------------------------------------------

var hint_text = "";

if (show_door_hint) {
    if (current_stage == 0) {
        hint_text = "E - подойти к двери паба";
    }
    else if (current_stage == 2) {
        hint_text = "E - войти в паб";
    }
}

if (show_scene_hint) {
    hint_text = "E - поговорить с Джозофом";
}

if (hint_text != "") {
    draw_set_alpha(0.82);
    draw_set_color(c_black);
    draw_rectangle(gui_w * 0.5 - 230, gui_h - 82, gui_w * 0.5 + 230, gui_h - 34, false);

    draw_set_alpha(1);
    draw_set_color(c_white);
    draw_rectangle(gui_w * 0.5 - 230, gui_h - 82, gui_w * 0.5 + 230, gui_h - 34, true);

    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text(gui_w * 0.5, gui_h - 58, hint_text);
}


// --------------------------------------------------
// ЗАТЕМНЕНИЕ МЕЖДУ КАДРАМИ
// --------------------------------------------------

if (fade_active_local) {
    draw_set_alpha(clamp(fade_alpha_local, 0, 1));
    draw_set_color(c_black);
    draw_rectangle(0, 0, gui_w, gui_h, false);
    draw_set_alpha(1);
}


// --------------------------------------------------
// СБРОС
// --------------------------------------------------

draw_set_alpha(1);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
