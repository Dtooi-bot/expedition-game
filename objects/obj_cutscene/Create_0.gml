// obj_cutscene
// Create Event
// Единый постоянный контроллер диалогов.

if (instance_number(obj_cutscene) > 1) {
    instance_destroy();
    exit;
}

persistent = true;
depth = -90000;

scr_game_init();
scr_game_state_init();

active = false;
dialogue_open = false;
choice_open = false;

dialogue_type = 0;
// 0 = диалога нет
// 1 = простая реплика
// 2 = диалог с дочерью

dialogue_step = 0;
speaker = "";
dialogue_text = "";

choice_index = 0;
choice_options = [];

pause_frames = 0;


// Завершает текущий диалог и возвращает исследование.
finish_dialogue = function() {
    active = false;
    dialogue_open = false;
    choice_open = false;

    dialogue_type = 0;
    dialogue_step = 0;

    speaker = "";
    dialogue_text = "";
    choice_options = [];
    choice_index = 0;
    pause_frames = 0;

    scr_game_state_set(GameState.EXPLORE);
};


// Запускает обычную одиночную реплику.
// Эту функцию используют жена, Джозоф и интерактивные предметы.
start_simple_dialogue = function(_speaker, _text) {
    if (!scr_game_state_is(GameState.EXPLORE)) {
        return;
    }

    active = true;
    dialogue_open = true;
    choice_open = false;

    dialogue_type = 1;
    dialogue_step = 0;

    speaker = _speaker;
    dialogue_text = _text;

    choice_options = [];
    choice_index = 0;
    pause_frames = 0;

    scr_game_state_set(GameState.DIALOGUE);
};


// Запускает полноценный диалог с дочерью.
start_daughter_dialogue = function() {
    if (!scr_game_state_is(GameState.EXPLORE)) {
        return;
    }

    active = true;
    dialogue_open = true;
    choice_open = false;

    dialogue_type = 2;
    dialogue_step = 0;

    speaker = "Дочь";
    dialogue_text = "Пап, ты опять уходишь?";

    choice_options = [
        "Да.",
        "Нет. Я разбужу тебя перед уходом.",
        "Если получится, я останусь ненадолго."
    ];

    choice_index = 0;
    pause_frames = 0;

    scr_game_state_set(GameState.DIALOGUE);
};


// Применяет выбранный ответ.
// Пока сохраняем сам факт обещания, но не меняем доверие автоматически.
apply_daughter_choice = function(_selected_index) {
    global.daughter_departure_choice = _selected_index;
    global.daughter_departure_choice_done = true;

    global.promised_to_wake_daughter = (_selected_index == 1);
    global.promised_to_stay_with_daughter = (_selected_index == 2);
};
