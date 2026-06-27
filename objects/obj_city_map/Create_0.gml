// obj_city_map
// Create Event
// Контроллер карты города.
// Сейчас активна только одна точка выбора: Паб.

scr_game_init();
scr_game_state_init();

depth = -1000000;

global.location_map_active = true;
scr_game_state_set(GameState.MENU);


// Размер исходного изображения карты.
map_source_width = 1448;
map_source_height = 1086;


// Активная область "Паб" в координатах исходной картинки.
pub_x1 = 315;
pub_y1 = 118;
pub_x2 = 475;
pub_y2 = 255;

pub_hover = false;


// Переход после выбора.
map_fade_active = false;
map_fade_alpha = 0;
map_fade_speed = 1 / 45;
map_target_room_name = "";
