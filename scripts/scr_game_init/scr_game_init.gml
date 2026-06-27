// scr_game_init
// Инициализирует новую игру только один раз.
// Повторное создание контроллера больше не сбрасывает сделанные выборы.

function scr_game_init() {
    if (
        variable_global_exists("game_initialized")
        && global.game_initialized
    ) {
        return;
    }

    global.game_initialized = true;

    // Экспедиция
    global.food_base = 20;
    global.wood_base = 10;
    global.rum_base = 8;
    global.gunpowder_base = 5;

    global.food = global.food_base;
    global.wood = global.wood_base;
    global.rum = global.rum_base;
    global.gunpowder = global.gunpowder_base;

    global.start_gold = 300;
    global.expedition_gold = global.start_gold;

    // Команда
    global.crew_trust = 50;
    global.crew_loyalty = 50;

    global.joseph_trust = 60;
    global.william_trust = 50;
    global.thomas_trust = 55;
    global.tom_trust = 50;

    // Семья
    global.wife_health = 80;
    global.wife_trust = 70;
    global.wife_loyalty = 95;

    global.daughter_health = 80;
    global.daughter_trust = 90;
    global.daughter_loyalty = 100;

    // Решение о деньгах семьи
    global.family_money_left = false;
    global.family_choice_done = false;

    // Ответ дочери перед уходом
    global.daughter_departure_choice = -1;
    global.daughter_departure_choice_done = false;
    global.promised_to_wake_daughter = false;
    global.promised_to_stay_with_daughter = false;

    // Ответ жены перед уходом
    global.wife_expedition_choice = -1;
    global.wife_expedition_choice_done = false;

    // Переход из дома в гавань
    global.prologue_final_started = false;
    global.prologue_harbor_transition_done = false;
}


// Ограничивает показатели семьи диапазоном от 0 до 100.
function scr_clamp_family_stats() {
    global.wife_health = clamp(global.wife_health, 0, 100);
    global.wife_trust = clamp(global.wife_trust, 0, 100);
    global.wife_loyalty = clamp(global.wife_loyalty, 0, 100);

    global.daughter_health = clamp(global.daughter_health, 0, 100);
    global.daughter_trust = clamp(global.daughter_trust, 0, 100);
    global.daughter_loyalty = clamp(global.daughter_loyalty, 0, 100);
}


// Применяет выбор между деньгами семье и запасами экспедиции.
function scr_apply_family_money_choice(_leave_money_to_family) {
    global.family_money_left = _leave_money_to_family;
    global.family_choice_done = true;

    if (_leave_money_to_family) {
        global.expedition_gold = global.start_gold - 100;

        global.wife_trust += 15;
        global.wife_loyalty += 5;

        global.daughter_trust += 10;
        global.daughter_loyalty += 5;

        global.food = floor(global.food_base * 0.7);
        global.wood = floor(global.wood_base * 0.7);
        global.rum = floor(global.rum_base * 0.7);
        global.gunpowder = floor(global.gunpowder_base * 0.7);
    }
    else {
        global.expedition_gold = global.start_gold;

        global.wife_trust -= 20;
        global.wife_loyalty -= 10;

        global.daughter_trust -= 15;
        global.daughter_loyalty -= 10;

        global.food = floor(global.food_base * 1.3);
        global.wood = floor(global.wood_base * 1.3);
        global.rum = floor(global.rum_base * 1.3);
        global.gunpowder = floor(global.gunpowder_base * 1.3);
    }

    scr_clamp_family_stats();
}
