// obj_family_status
// Draw GUI Event
// Рисует статичную картинку меню и динамические проценты/шкалы.

scr_game_state_init();

var menu_visible = (
    global.game_state == GameState.MENU
    || (
        global.game_state == GameState.PAUSE
        && global.game_state_before_pause == GameState.MENU
    )
);

if (!menu_visible) {
    exit;
}

scr_game_init();


// Если спрайт ещё не создан или назван иначе,
// покажем понятную ошибку вместо падения.
if (!sprite_exists(spr_ui_relationships_menu)) {
    draw_set_font(fnt_ui_cyrillic);
    draw_set_color(c_white);
    draw_text(32, 32, "Нет спрайта spr_ui_relationships_menu");
    exit;
}


// --------------------------------------------------
// 1. РИСУЕМ СТАТИЧНУЮ КАРТИНКУ МЕНЮ
// --------------------------------------------------

var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();

var src_w = sprite_get_width(spr_ui_relationships_menu);
var src_h = sprite_get_height(spr_ui_relationships_menu);

var scale_value = min(gui_w / src_w, gui_h / src_h);

var menu_w = src_w * scale_value;
var menu_h = src_h * scale_value;

var menu_x = (gui_w - menu_w) * 0.5;
var menu_y = (gui_h - menu_h) * 0.5;

draw_set_alpha(1);
draw_set_color(c_white);
draw_sprite_ext(
    spr_ui_relationships_menu,
    0,
    menu_x,
    menu_y,
    scale_value,
    scale_value,
    0,
    c_white,
    1
);


// --------------------------------------------------
// 2. ОБЩИЕ НАСТРОЙКИ ТЕКСТА
// --------------------------------------------------

draw_set_font(fnt_ui_cyrillic);
draw_set_halign(fa_left);
draw_set_valign(fa_middle);


// --------------------------------------------------
// 3. ДАННЫЕ
// --------------------------------------------------

var joseph_value = clamp(global.joseph_trust, 0, 100);
var william_value = clamp(global.william_trust, 0, 100);
var thomas_value = clamp(global.thomas_trust, 0, 100);
var tom_value = clamp(global.tom_trust, 0, 100);

var wife_health_value = clamp(global.wife_health, 0, 100);
var wife_trust_value = clamp(global.wife_trust, 0, 100);
var wife_loyalty_value = clamp(global.wife_loyalty, 0, 100);

var daughter_health_value = clamp(global.daughter_health, 0, 100);
var daughter_trust_value = clamp(global.daughter_trust, 0, 100);
var daughter_loyalty_value = clamp(global.daughter_loyalty, 0, 100);


// --------------------------------------------------
// 4. ЦВЕТА
// --------------------------------------------------

var col_green = make_color_rgb(91, 185, 45);
var col_yellow = make_color_rgb(225, 177, 35);
var col_red = make_color_rgb(215, 62, 45);
var col_blue = make_color_rgb(76, 154, 207);

var col_bar_back = make_color_rgb(18, 14, 10);
var col_bar_border = make_color_rgb(92, 66, 30);

var col_text_green = make_color_rgb(135, 220, 80);
var col_text_yellow = make_color_rgb(245, 201, 55);
var col_text_red = make_color_rgb(240, 76, 58);
var col_text_blue = make_color_rgb(105, 185, 240);


// --------------------------------------------------
// 5. ЭКИПАЖ: ПРОЦЕНТЫ И ШКАЛЫ
// --------------------------------------------------

// Общие координаты экипажа в системе исходной картинки.
var crew_text_x = menu_x + 540 * scale_value;
var crew_bar_x = menu_x + 263 * scale_value;

var crew_bar_w = 367 * scale_value;
var crew_bar_h = 16 * scale_value;

var crew_row_y = [
    407,
    528,
    649,
    770
];

var crew_bar_y = [
    437,
    558,
    679,
    800
];

var crew_values = [
    joseph_value,
    william_value,
    thomas_value,
    tom_value
];

for (var i = 0; i < 4; i++) {
    var value = crew_values[i];

    var value_color = col_text_green;
    var bar_color = col_green;

    if (value < 70) {
        value_color = col_text_yellow;
        bar_color = col_yellow;
    }

    if (value < 45) {
        value_color = col_text_red;
        bar_color = col_red;
    }

    var ty = menu_y + crew_row_y[i] * scale_value;
    var by = menu_y + crew_bar_y[i] * scale_value;

    // Текст значения
    draw_set_color(value_color);
    draw_text(
        crew_text_x,
        ty,
        string(round(value)) + "/100"
    );

    // Фон шкалы
    draw_set_color(col_bar_back);
    draw_rectangle(
        crew_bar_x,
        by,
        crew_bar_x + crew_bar_w,
        by + crew_bar_h,
        false
    );

    // Заполнение шкалы
    draw_set_color(bar_color);
    draw_rectangle(
        crew_bar_x + 2 * scale_value,
        by + 2 * scale_value,
        crew_bar_x + 2 * scale_value + (crew_bar_w - 4 * scale_value) * value / 100,
        by + crew_bar_h - 2 * scale_value,
        false
    );

    // Рамка шкалы
    draw_set_color(col_bar_border);
    draw_rectangle(
        crew_bar_x,
        by,
        crew_bar_x + crew_bar_w,
        by + crew_bar_h,
        true
    );
}


// --------------------------------------------------
// 6. СЕМЬЯ: ПРОЦЕНТЫ И ШКАЛЫ
// --------------------------------------------------

var family_text_x = menu_x + 1046 * scale_value;
var family_bar_x = menu_x + 1121 * scale_value;

var family_bar_w = 127 * scale_value;
var family_bar_h = 15 * scale_value;

var family_text_y = [
    418,
    466,
    512,
    655,
    704,
    750
];

var family_bar_y = [
    429,
    477,
    523,
    666,
    715,
    761
];

var family_values = [
    wife_health_value,
    wife_trust_value,
    wife_loyalty_value,
    daughter_health_value,
    daughter_trust_value,
    daughter_loyalty_value
];

var family_bar_colors = [
    col_red,
    col_blue,
    col_yellow,
    col_red,
    col_blue,
    col_yellow
];

var family_text_colors = [
    col_text_red,
    col_text_blue,
    col_text_yellow,
    col_text_red,
    col_text_blue,
    col_text_yellow
];

for (var j = 0; j < 6; j++) {
    var stat_value = family_values[j];

    var fty = menu_y + family_text_y[j] * scale_value;
    var fby = menu_y + family_bar_y[j] * scale_value;

    // Текст значения
    draw_set_color(family_text_colors[j]);
    draw_text(
        family_text_x,
        fty,
        string(round(stat_value)) + "/100"
    );

    // Фон шкалы
    draw_set_color(col_bar_back);
    draw_rectangle(
        family_bar_x,
        fby,
        family_bar_x + family_bar_w,
        fby + family_bar_h,
        false
    );

    // Заполнение шкалы
    draw_set_color(family_bar_colors[j]);
    draw_rectangle(
        family_bar_x + 2 * scale_value,
        fby + 2 * scale_value,
        family_bar_x + 2 * scale_value + (family_bar_w - 4 * scale_value) * stat_value / 100,
        fby + family_bar_h - 2 * scale_value,
        false
    );

    // Рамка шкалы
    draw_set_color(col_bar_border);
    draw_rectangle(
        family_bar_x,
        fby,
        family_bar_x + family_bar_w,
        fby + family_bar_h,
        true
    );
}


// --------------------------------------------------
// 7. СБРОС НАСТРОЕК РИСОВАНИЯ
// --------------------------------------------------

draw_set_alpha(1);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
