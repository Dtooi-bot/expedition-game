// obj_family_status
// Step Event
// Обрабатывает клик по нарисованной кнопке "Закрыть".

scr_game_state_init();

if (global.game_state != GameState.MENU) {
    exit;
}


// Если спрайт меню ещё не создан или назван иначе,
// Step не должен ломать игру.
if (!sprite_exists(spr_ui_relationships_menu)) {
    exit;
}


// Рассчитываем, где на экране находится картинка меню.
// Это нужно, потому что картинка масштабируется под размер окна.
var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();

var src_w = sprite_get_width(spr_ui_relationships_menu);
var src_h = sprite_get_height(spr_ui_relationships_menu);

var scale_value = min(gui_w / src_w, gui_h / src_h);

var menu_w = src_w * scale_value;
var menu_h = src_h * scale_value;

var menu_x = (gui_w - menu_w) * 0.5;
var menu_y = (gui_h - menu_h) * 0.5;


// Координаты мыши именно в GUI, а не в комнате.
var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);


// Переводим координаты кнопки из исходной картинки в экранные координаты.
var close_x1 = menu_x + close_button_x1 * scale_value;
var close_y1 = menu_y + close_button_y1 * scale_value;
var close_x2 = menu_x + close_button_x2 * scale_value;
var close_y2 = menu_y + close_button_y2 * scale_value;


if (mouse_check_button_pressed(mb_left)) {
    if (
        mx >= close_x1
        && mx <= close_x2
        && my >= close_y1
        && my <= close_y2
    ) {
        scr_game_state_set(GameState.EXPLORE);
    }
}
