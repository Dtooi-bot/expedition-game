// obj_cutscene
// Create Event
// Единый постоянный контроллер диалогов.
// Управляет дочерью, женой, Джозофом и плашками отношений.

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
// 3 = диалог с женой
// 4 = диалог с Джозофом у паба на улице
// 5 = диалог с Джозофом внутри паба

dialogue_step = 0;
speaker = "";
dialogue_text = "";

choice_index = 0;
choice_options = [];
last_choice_index = -1;

pause_frames = 0;
pause_next_step = 0;
pause_next_speaker = "";
pause_next_text = "";
pause_finish_after = false;

final_question_timer = 0;
final_silence_timer = 0;


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


// --------------------------------------------------
// ЗАТЕМНЕНИЕ И ПЕРЕХОД ИЗ ДОМА НА КАРТУ ГОРОДА
// --------------------------------------------------

fade_active = false;
fade_alpha = 0;
fade_speed = 1 / 120;


// Запускает плашку изменения отношений.
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


// Запускает внутреннюю паузу внутри диалога.
start_dialogue_pause = function(
    _frames,
    _next_step,
    _next_speaker,
    _next_text,
    _finish_after
) {
    speaker = "";
    dialogue_text = "...";

    pause_frames = max(1, _frames);
    pause_next_step = _next_step;
    pause_next_speaker = _next_speaker;
    pause_next_text = _next_text;
    pause_finish_after = _finish_after;
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
    last_choice_index = -1;

    pause_frames = 0;
    pause_finish_after = false;

    scr_game_state_set(GameState.EXPLORE);
};


// Запускает затемнение перед переходом из дома.
begin_harbor_transition = function() {
    active = false;
    dialogue_open = false;
    choice_open = false;

    fade_active = true;
    fade_alpha = 0;

    global.prologue_final_started = true;

    scr_game_state_set(GameState.DIALOGUE);
};


// Запускает обычную одиночную реплику.
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
    last_choice_index = -1;
    pause_frames = 0;

    scr_game_state_set(GameState.DIALOGUE);
};


// Запускает диалог с дочерью.
start_daughter_dialogue = function() {
    if (!scr_game_state_is(GameState.EXPLORE)) {
        return;
    }

    if (
        variable_global_exists("daughter_departure_choice_done")
        && global.daughter_departure_choice_done
    ) {
        start_simple_dialogue(
            "Герой",
            "Люсия выглядит болезненно... Я сделаю все, что в моих силах, чтобы вылечить ее."
        );

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
        "Да... Мне нужно выйти до рассвета.",
        "Нет. Я разбужу тебя перед уходом."
    ];

    choice_index = 0;
    last_choice_index = -1;
    pause_frames = 0;

    scr_game_state_set(GameState.DIALOGUE);
};


// Запускает диалог с женой.
start_wife_dialogue = function() {
    if (!scr_game_state_is(GameState.EXPLORE)) {
        return;
    }

    if (
        !variable_global_exists("daughter_departure_choice_done")
        || !global.daughter_departure_choice_done
    ) {
        start_simple_dialogue(
            "Жена",
            "Поговори с Люсией. Она ждала тебя весь день."
        );

        return;
    }

    if (
        variable_global_exists("wife_expedition_choice_done")
        && global.wife_expedition_choice_done
    ) {
        start_simple_dialogue(
            "Жена",
            "Ты уже всё сказал. Осталось только уйти."
        );

        return;
    }

    active = true;
    dialogue_open = true;
    choice_open = false;

    dialogue_type = 3;
    dialogue_step = 0;

    speaker = "Жена";
    dialogue_text = "Она весь день ждала, что ты останешься хотя бы сегодня.";

    choice_options = [
        "Да. Иначе я бы не уходил.",
        "Нет. Но другого пути нет.",
        "Мне приходится верить."
    ];

    choice_index = 0;
    last_choice_index = -1;
    pause_frames = 0;

    scr_game_state_set(GameState.DIALOGUE);
};


// Запускает короткую уличную сцену с Джозофом перед входом в паб.
// Оставляем отдельно, чтобы не ломать переход улица -> паб.
start_joseph_pub_dialogue = function() {
    if (
        global.game_state == GameState.DIALOGUE
        || global.game_state == GameState.CHOICE
        || active
    ) {
        return;
    }

    if (
        variable_global_exists("joseph_pub_choice_done")
        && global.joseph_pub_choice_done
    ) {
        start_simple_dialogue(
            "Герой",
            "С Джозофом уже все решено. Пора двигаться дальше."
        );
        return;
    }

    active = true;
    dialogue_open = true;
    choice_open = false;

    dialogue_type = 4;
    dialogue_step = 0;

    speaker = "Джозоф";
    dialogue_text = "Ну наконец-то!";

    choice_options = [
        "Я рассчитываю на тебя.",
        "Ты уверен? Обратной дороги может не быть.",
        "Еще не поздно отказаться."
    ];

    choice_index = 0;
    last_choice_index = -1;
    pause_frames = 0;

    scr_game_state_set(GameState.DIALOGUE);
};


// Запускает большой диалог с Джозофом уже внутри паба.
start_joseph_pub_interior_dialogue = function() {
    if (
        global.game_state == GameState.DIALOGUE
        || global.game_state == GameState.CHOICE
        || active
    ) {
        return;
    }

    if (
        variable_global_exists("joseph_inside_pub_choice_done")
        && global.joseph_inside_pub_choice_done
    ) {
        start_simple_dialogue(
            "Джозоф",
            "Не стой столбом. Если идем в ад, лучше выйти до закрытия."
        );
        return;
    }

    active = true;
    dialogue_open = true;
    choice_open = false;

    dialogue_type = 5;
    dialogue_step = 0;

    speaker = "Джозоф";
    dialogue_text = "Вечно одно и то же...";

    choice_options = [
        "Спасибо. Мне нужен именно такой человек.",
        "Подумай еще раз.#Обратной дороги может не быть.",
        "Я не могу обещать, что мы вернемся."
    ];

    choice_index = 0;
    last_choice_index = -1;
    pause_frames = 0;

    scr_game_state_set(GameState.DIALOGUE);
};


// Применяет выбранный ответ дочери.
apply_daughter_choice = function(_selected_index) {
    global.daughter_departure_choice = _selected_index;
    global.daughter_departure_choice_done = true;

    global.promised_to_wake_daughter = (_selected_index == 1);
    global.promised_to_stay_with_daughter = false;

    var trust_delta = 0;
    var loyalty_delta = 0;

    switch (_selected_index) {
        case 0:
            loyalty_delta = -10;
            break;

        case 1:
            loyalty_delta = 10;
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


// Применяет выбранный ответ жены.
apply_wife_choice = function(_selected_index) {
    global.wife_expedition_choice = _selected_index;
    global.wife_expedition_choice_done = true;

    var trust_delta = 0;
    var loyalty_delta = 0;

    switch (_selected_index) {
        case 0:
            trust_delta = 0;
            loyalty_delta = 0;
            break;

        case 1:
            trust_delta = -20;
            loyalty_delta = -20;
            break;

        case 2:
            trust_delta = 10;
            loyalty_delta = -15;
            break;
    }

    if (trust_delta != 0 || loyalty_delta != 0) {
        global.wife_trust += trust_delta;
        global.wife_loyalty += loyalty_delta;

        scr_clamp_family_stats();

        show_relation_popup(
            "Жена",
            global.wife_trust,
            global.wife_loyalty,
            trust_delta,
            loyalty_delta
        );
    }
};


// Применяет выбранный ответ в уличной сцене у паба.
apply_joseph_choice = function(_selected_index) {
    global.joseph_pub_choice = _selected_index;
    global.joseph_pub_choice_done = true;

    var trust_delta = 0;
    var loyalty_delta = 0;

    switch (_selected_index) {
        case 0:
            trust_delta = 10;
            break;

        case 1:
            break;

        case 2:
            loyalty_delta = 10;
            break;
    }

    if (trust_delta != 0 || loyalty_delta != 0) {
        global.joseph_trust += trust_delta;
        global.joseph_loyalty += loyalty_delta;

        scr_clamp_family_stats();

        show_relation_popup(
            "Джозоф",
            global.joseph_trust,
            global.joseph_loyalty,
            trust_delta,
            loyalty_delta
        );
    }
};


// Применяет выбранный ответ в большом диалоге внутри паба.
apply_joseph_pub_interior_choice = function(_selected_index) {
    global.joseph_inside_pub_choice = _selected_index;
    global.joseph_inside_pub_choice_done = true;

    var trust_delta = 0;
    var loyalty_delta = 0;

    switch (_selected_index) {
        case 0:
            // "Спасибо. Мне нужен именно такой человек."
            trust_delta = 10;
            break;

        case 1:
            // "Подумай еще раз. Обратной дороги может не быть."
            // Без изменений.
            break;

        case 2:
            // "Я не могу обещать, что мы вернемся."
            loyalty_delta = 10;
            break;
    }

    if (trust_delta != 0 || loyalty_delta != 0) {
        global.joseph_trust += trust_delta;
        global.joseph_loyalty += loyalty_delta;

        scr_clamp_family_stats();

        show_relation_popup(
            "Джозоф",
            global.joseph_trust,
            global.joseph_loyalty,
            trust_delta,
            loyalty_delta
        );
    }
};
