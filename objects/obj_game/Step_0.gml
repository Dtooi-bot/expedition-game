// obj_game
// Step Event
// Управляет общими режимами меню и паузы.

scr_game_state_init();


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
