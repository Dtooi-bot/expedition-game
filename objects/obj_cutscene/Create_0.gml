// obj_cutscene
// Create Event
// Единый постоянный контроллер диалогов.
// Теперь также показывает временную плашку изменения отношений.

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


// --------------------------------------------------
// ПЛАШКА ИЗМЕНЕНИЯ ОТНОШЕНИЙ
// --------------------------------------------------

relation_popup_active = false;
relation_popup_timer = 0;
relation_popup_duration = 180;

relation_popup_character_name = "";
relation_popup_trust_value = 0;
relation_popup_loyalty_value = 0;
relation_popup_trust_delta = 0;
relation_popup_loyalty_delta = 0;

relation_popup_scale = 0.48;
relation_popup_margin_x = 24;
relation_popup_margin_y = 24;


// Запускает плашку изменения отношений.
// _trust_delta и _loyalty_delta показывают, что именно изменилось.
show_relation_popup = function(
    _character_name,
    _trust_value,
    _loyalty_value,
    _trust_delta,
    _loyalty_delta
) {
    relation_popup_active = true;
    relation_popup_timer = relation_popup_duration;

    relation_popup_character_name = _character_name;
    relation_popup_trust_value = clamp(_trust_value, 0, 100);
    relation_popup_loyalty_value = clamp(_loyalty_value, 0, 100);
    relation_popup_trust_delta = _trust_delta;
    relation_popup_loyalty_delta = _loyalty_delta;
};


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


// Применяет выбранный ответ дочери.
// Здесь меняется доверие и запускается визуальное уведомление.
apply_daughter_choice = function(_selected_index) {
    global.daughter_departure_choice = _selected_index;
    global.daughter_departure_choice_done = true;

    global.promised_to_wake_daughter = (_selected_index == 1);
    global.promised_to_stay_with_daughter = (_selected_index == 2);

    var trust_delta = 0;
    var loyalty_delta = 0;

    switch (_selected_index) {
        case 0:
            // "Да."
            // Смысл: герой подтверждает худший страх дочери.
            trust_delta = -10;
            break;

        case 1:
            // "Нет. Я разбужу тебя перед уходом."
            // Смысл: герой не исчезает молча и даёт обещание.
            trust_delta = 10;
            break;

        case 2:
            // "Если получится, я останусь ненадолго."
            // Пока без числового эффекта.
            // Это обещание лучше проверять позже отдельным событием.
            trust_delta = 0;
            break;
    }

    if (trust_delta != 0 || loyalty_delta != 0) {
        global.daughter_trust += trust_delta;
        global.daughter_loyalty += loyalty_delta;

        scr_clamp_family_stats();

        show_relation_popup(
            "Дочь",
            global.daughter_trust,
            global.daughter_loyalty,
            trust_delta,
            loyalty_delta
        );
    }
};
