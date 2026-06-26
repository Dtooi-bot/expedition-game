// scr_game_state
// Единый автомат состояний игры.

enum GameState {
    EXPLORE = 0,
    DIALOGUE = 1,
    CHOICE = 2,
    MENU = 3,
    PAUSE = 4
}


// Создаёт переменные состояний, если они ещё не существуют.
function scr_game_state_init() {
    if (!variable_global_exists("game_state")) {
        global.game_state = GameState.EXPLORE;
    }

    if (!variable_global_exists("game_state_before_pause")) {
        global.game_state_before_pause = GameState.EXPLORE;
    }
}


// Переводит игру в указанное состояние.
function scr_game_state_set(_new_state) {
    scr_game_state_init();
    global.game_state = _new_state;
}


// Проверяет текущее состояние.
function scr_game_state_is(_state) {
    scr_game_state_init();
    return global.game_state == _state;
}


// Ставит игру на паузу и запоминает предыдущий режим.
function scr_game_pause() {
    scr_game_state_init();

    if (global.game_state != GameState.PAUSE) {
        global.game_state_before_pause = global.game_state;
        global.game_state = GameState.PAUSE;
    }
}


// Возвращает игру в состояние, из которого была включена пауза.
function scr_game_resume() {
    scr_game_state_init();

    if (global.game_state == GameState.PAUSE) {
        global.game_state = global.game_state_before_pause;
    }
}
