// obj_city_map
// Draw GUI Event
// Рисует карту города и подсветку активной области "Паб".

draw_set_font(fnt_ui_cyrillic);

var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();

var map_sprite = asset_get_index("spr_ui_city_map");

if (map_sprite == -1) {
    draw_set_color(c_white);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_text(32, 32, "Нет спрайта spr_ui_city_map");
    exit;
}


// --------------------------------------------------
// КАРТА
// --------------------------------------------------

var src_w = sprite_get_width(map_sprite);
var src_h = sprite_get_height(map_sprite);

var scale_value = min(gui_w / src_w, gui_h / src_h);

var map_w = src_w * scale_value;
var map_h = src_h * scale_value;

var map_x = (gui_w - map_w) * 0.5;
var map_y = (gui_h - map_h) * 0.5;

draw_set_alpha(1);
draw_set_color(c_white);
draw_sprite_ext(
    map_sprite,
    0,
    map_x,
    map_y,
    scale_value,
    scale_value,
    0,
    c_white,
    1
);


// --------------------------------------------------
// ПОДСВЕТКА ПАБА
// --------------------------------------------------

var pub_screen_x1 = map_x + pub_x1 * scale_value;
var pub_screen_y1 = map_y + pub_y1 * scale_value;
var pub_screen_x2 = map_x + pub_x2 * scale_value;
var pub_screen_y2 = map_y + pub_y2 * scale_value;

if (pub_hover) {
    draw_set_alpha(0.22);
    draw_set_color(make_color_rgb(255, 210, 80));
    draw_rectangle(
        pub_screen_x1,
        pub_screen_y1,
        pub_screen_x2,
        pub_screen_y2,
        false
    );

    draw_set_alpha(1);
    draw_set_color(make_color_rgb(255, 230, 120));
    draw_rectangle(
        pub_screen_x1,
        pub_screen_y1,
        pub_screen_x2,
        pub_screen_y2,
        true
    );
}


// --------------------------------------------------
// ПОДСКАЗКА
// --------------------------------------------------

draw_set_alpha(0.85);
draw_set_color(c_black);
draw_rectangle(32, gui_h - 72, gui_w - 32, gui_h - 24, false);

draw_set_alpha(1);
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text(
    gui_w * 0.5,
    gui_h - 48,
    "Паб доступен: ЛКМ по Пабу или Enter"
);


// --------------------------------------------------
// ЗАТЕМНЕНИЕ ПРИ ВЫБОРЕ
// --------------------------------------------------

if (map_fade_active) {
    draw_set_alpha(clamp(map_fade_alpha, 0, 1));
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
