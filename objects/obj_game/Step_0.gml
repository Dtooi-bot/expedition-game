// obj_game
// Step Event
// Управляет общими режимами меню и паузы.

scr_game_state_init();


// Пока открыта карта города, obj_city_map сам управляет вводом.
// Это нужно, чтобы Escape и I не переводили карту в обычный режим исследования.
if (
    variable_global_exists("location_map_active")
    && global.location_map_active
) {
    exit;
}


// Escape
if (keyboard_check_pressed(vk_escape)) {
    switch (global.game_state) {
        case GameState.PAUSE:
            scr_game_resume();
            break;

        case GameState.MENU:
            scr_game_state_set(GameState.EXPLORE);
            break;

        default:
            scr_game_pause();
            break;
    }

    exit;
}


// I открывает меню семьи только из исследования.
// Повторное нажатие I закрывает его.
if (keyboard_check_pressed(ord("I"))) {
    if (global.game_state == GameState.EXPLORE) {
        scr_game_state_set(GameState.MENU);
    }
    else if (global.game_state == GameState.MENU) {
        scr_game_state_set(GameState.EXPLORE);
    }
}
