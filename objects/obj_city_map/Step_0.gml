// obj_city_map
// Step Event
// Проверяет выбор Паба на карте города.

global.location_map_active = true;
scr_game_state_set(GameState.MENU);


// --------------------------------------------------
// ПЛАВНЫЙ ПЕРЕХОД В ВЫБРАННУЮ ЛОКАЦИЮ
// --------------------------------------------------

if (map_fade_active) {
    map_fade_alpha += map_fade_speed;

    if (map_fade_alpha >= 1) {
        map_fade_alpha = 1;

        global.location_map_active = false;
        scr_game_state_set(GameState.EXPLORE);

        var target_room = asset_get_index(map_target_room_name);

        if (target_room != -1) {
            room_goto(target_room);
        }
        else {
            // Запасной переход, чтобы проект не падал,
            // если rm_pub_entrance ещё не создана.
            var harbor_room = asset_get_index("rm_harbor");

            if (harbor_room != -1) {
                room_goto(harbor_room);
            }
            else {
                room_goto(rm_ship);
            }
        }
    }

    exit;
}


// --------------------------------------------------
// ПРОВЕРКА СПРАЙТА КАРТЫ
// --------------------------------------------------

var map_sprite = asset_get_index("spr_ui_city_map");

if (map_sprite == -1) {
    pub_hover = false;
    exit;
}


// --------------------------------------------------
// ПЕРЕВОД МЫШИ В КООРДИНАТЫ ИСХОДНОЙ КАРТЫ
// --------------------------------------------------

var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();

var src_w = sprite_get_width(map_sprite);
var src_h = sprite_get_height(map_sprite);

var scale_value = min(gui_w / src_w, gui_h / src_h);

var map_w = src_w * scale_value;
var map_h = src_h * scale_value;

var map_x = (gui_w - map_w) * 0.5;
var map_y = (gui_h - map_h) * 0.5;

var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);

var source_x = (mx - map_x) / scale_value;
var source_y = (my - map_y) / scale_value;


// --------------------------------------------------
// ПАБ
// --------------------------------------------------

pub_hover = (
    source_x >= pub_x1
    && source_x <= pub_x2
    && source_y >= pub_y1
    && source_y <= pub_y2
);

var choose_pub = false;

if (pub_hover && mouse_check_button_pressed(mb_left)) {
    choose_pub = true;
}

// Пока на карте активен только Паб,
// Enter тоже выбирает его.
if (keyboard_check_pressed(vk_enter)) {
    choose_pub = true;
}

if (choose_pub) {
    map_target_room_name = "rm_pub_entrance";
    map_fade_active = true;
    map_fade_alpha = 0;
}
