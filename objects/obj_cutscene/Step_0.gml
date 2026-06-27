// obj_cutscene
// Step Event
// Управляет диалогами дочери, жены и Джозофа,
// выбором, паузами, плашками отношений и переходом на карту города.


// --------------------------------------------------
// ТАЙМЕР ПЛАШКИ ОТНОШЕНИЙ
// --------------------------------------------------

if (relation_popup_active) {
    relation_popup_timer -= 1;

    if (relation_popup_timer <= 0) {
        relation_popup_timer = 0;
        relation_popup_active = false;
    }
}


// --------------------------------------------------
// ЗАТЕМНЕНИЕ И ПЕРЕХОД НА КАРТУ ГОРОДА
// --------------------------------------------------

if (fade_active) {
    fade_alpha += fade_speed;

    if (fade_alpha >= 1) {
        fade_alpha = 1;
        fade_active = false;

        global.prologue_harbor_transition_done = true;

        var city_map_room = asset_get_index("rm_city_map");

        if (city_map_room != -1) {
            room_goto(city_map_room);
        }
        else {
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
// ФИНАЛЬНАЯ ТИШИНА ПЕРЕД ЗАТЕМНЕНИЕМ
// --------------------------------------------------

if (final_silence_timer > 0) {
    final_silence_timer -= 1;

    if (final_silence_timer <= 0) {
        final_silence_timer = 0;
        begin_harbor_transition();
    }

    exit;
}


// --------------------------------------------------
// ФИНАЛЬНЫЙ ВОПРОС ЖЕНЫ БЕЗ ОТВЕТА ИГРОКА
// --------------------------------------------------

if (final_question_timer > 0) {
    final_question_timer -= 1;

    if (final_question_timer <= 0) {
        final_question_timer = 0;

        active = false;
        dialogue_open = false;
        choice_open = false;
        speaker = "";
        dialogue_text = "";

        final_silence_timer = round(game_get_speed(gamespeed_fps) * 1.5);
        scr_game_state_set(GameState.DIALOGUE);
    }

    exit;
}


if (!active) {
    exit;
}

scr_game_state_init();


if (global.game_state == GameState.PAUSE) {
    exit;
}


// --------------------------------------------------
// ВНУТРЕННЯЯ ПАУЗА В ДИАЛОГЕ
// --------------------------------------------------

if (pause_frames > 0) {
    pause_frames -= 1;

    if (pause_frames <= 0) {
        pause_frames = 0;

        if (pause_finish_after) {
            finish_dialogue();
        }
        else {
            dialogue_step = pause_next_step;
            speaker = pause_next_speaker;
            dialogue_text = pause_next_text;
        }

        pause_finish_after = false;
    }

    exit;
}


switch (global.game_state) {
    case GameState.DIALOGUE:
        if (keyboard_check_pressed(vk_enter)) {
            if (dialogue_type == 1) {
                finish_dialogue();
                break;
            }

            // --------------------------------------------------
            // ДИАЛОГ С ДОЧЕРЬЮ
            // --------------------------------------------------
            if (dialogue_type == 2) {
                switch (dialogue_step) {
                    case 0:
                        dialogue_step = 1;
                        speaker = "Герой";
                        dialogue_text = "Ненадолго.";
                        break;

                    case 1:
                        dialogue_step = 2;
                        speaker = "Дочь";
                        dialogue_text = "Ты всегда так говоришь...";
                        break;

                    case 2:
                        start_dialogue_pause(
                            round(game_get_speed(gamespeed_fps)),
                            4,
                            "Дочь",
                            "Когда я проснусь, тебя уже не будет?",
                            false
                        );
                        break;

                    case 4:
                        dialogue_open = false;
                        choice_open = true;
                        choice_index = 0;
                        scr_game_state_set(GameState.CHOICE);
                        break;

                    case 5:
                        if (last_choice_index == 0) {
                            dialogue_step = 6;
                            speaker = "Дочь";
                            dialogue_text = "Понятно...";
                        }
                        else {
                            dialogue_step = 10;
                            speaker = "Дочь";
                            dialogue_text = "Правда?";
                        }
                        break;

                    case 6:
                        start_dialogue_pause(
                            round(game_get_speed(gamespeed_fps)),
                            0,
                            "",
                            "",
                            true
                        );
                        break;

                    case 10:
                        dialogue_step = 11;
                        speaker = "Герой";
                        dialogue_text = "Обещаю.";
                        break;

                    case 11:
                        dialogue_step = 12;
                        speaker = "Дочь";
                        dialogue_text = "Тогда я не буду бояться.";
                        break;

                    case 12:
                        finish_dialogue();
                        break;
                }
            }


            // --------------------------------------------------
            // ДИАЛОГ С ЖЕНОЙ
            // --------------------------------------------------
            if (dialogue_type == 3) {
                switch (dialogue_step) {
                    case 0:
                        dialogue_step = 1;
                        speaker = "Герой";
                        dialogue_text = "Если останусь сегодня, завтра будет поздно.";
                        break;

                    case 1:
                        dialogue_step = 2;
                        speaker = "Жена";
                        dialogue_text = "Ты этого не знаешь.";
                        break;

                    case 2:
                        dialogue_step = 3;
                        speaker = "Герой";
                        dialogue_text = "А ты знаешь, что будет, если я ничего не сделаю?";
                        break;

                    case 3:
                        start_dialogue_pause(
                            round(game_get_speed(gamespeed_fps)),
                            4,
                            "Жена",
                            "Ты действительно веришь, что эта экспедиция что-то изменит?",
                            false
                        );
                        break;

                    case 4:
                        dialogue_open = false;
                        choice_open = true;
                        choice_index = 0;
                        scr_game_state_set(GameState.CHOICE);
                        break;

                    case 5:
                        dialogue_step = 6;
                        speaker = "Жена";
                        dialogue_text = "Если однажды тебе придется выбирать...";
                        break;

                    case 6:
                        dialogue_step = 7;
                        speaker = "Жена";
                        dialogue_text = "Между нами...";
                        break;

                    case 7:
                        dialogue_step = 8;
                        speaker = "Жена";
                        dialogue_text = "И тем, за чем ты уходишь...";
                        break;

                    case 8:
                        dialogue_step = 9;
                        speaker = "Жена";
                        dialogue_text = "Что ты выберешь?";
                        final_question_timer = round(game_get_speed(gamespeed_fps) * 2);
                        break;
                }
            }


            // --------------------------------------------------
            // ДИАЛОГ С ДЖОЗОФОМ У ПАБА
            // --------------------------------------------------
            if (dialogue_type == 4) {
                switch (dialogue_step) {
                    case 0:
                        dialogue_step = 1;
                        speaker = "Джозоф";
                        dialogue_text = "Я уж думал, ты передумал спасать мир.";
                        break;

                    case 1:
                        dialogue_step = 2;
                        speaker = "Герой";
                        dialogue_text = "Пока только пытаюсь собрать команду.";
                        break;

                    case 2:
                        dialogue_step = 3;
                        speaker = "Джозоф";
                        dialogue_text = "Ну, значит, начал с правильного человека.";
                        break;

                    case 3:
                        dialogue_step = 4;
                        speaker = "Герой";
                        dialogue_text = "Смотрю, работа идет спокойно.";
                        break;

                    case 4:
                        dialogue_step = 5;
                        speaker = "Джозоф";
                        dialogue_text = "Да этот решил, что может расплатиться обещаниями.";
                        break;

                    case 5:
                        dialogue_step = 6;
                        speaker = "Джозоф";
                        dialogue_text = "Хозяин попросил объяснить ему, как здесь принято платить.";
                        break;

                    case 6:
                        dialogue_step = 7;
                        speaker = "Джозоф";
                        dialogue_text = "Думаю, он понял.";
                        break;

                    case 7:
                        dialogue_step = 8;
                        speaker = "Джозоф";
                        dialogue_text = "Жена отпустила?";
                        break;

                    case 8:
                        dialogue_step = 9;
                        speaker = "Герой";
                        dialogue_text = "Скорее... смирилась.";
                        break;

                    case 9:
                        start_dialogue_pause(
                            round(game_get_speed(gamespeed_fps)),
                            10,
                            "Джозоф",
                            "Значит, все действительно плохо...",
                            false
                        );
                        break;

                    case 10:
                        dialogue_step = 11;
                        speaker = "Герой";
                        dialogue_text = "Хуже, чем я думал.";
                        break;

                    case 11:
                        dialogue_step = 12;
                        speaker = "Джозоф";
                        dialogue_text = "...";
                        break;

                    case 12:
                        dialogue_step = 13;
                        speaker = "Джозоф";
                        dialogue_text = "Тогда чего мы вообще стоим?";
                        break;

                    case 13:
                        dialogue_step = 14;
                        speaker = "Джозоф";
                        dialogue_text = "Пошли собирать эту проклятую экспедицию.";
                        break;

                    case 14:
                        dialogue_open = false;
                        choice_open = true;
                        choice_index = 0;
                        scr_game_state_set(GameState.CHOICE);
                        break;

                    case 15:
                        if (last_choice_index == 0) {
                            finish_dialogue();
                        }
                        else if (last_choice_index == 1) {
                            dialogue_step = 16;
                            speaker = "Джозоф";
                            dialogue_text = "Я не настолько умный, чтобы бояться заранее.";
                        }
                        else {
                            dialogue_step = 20;
                            speaker = "Джозоф";
                            dialogue_text = "Поздно.";
                        }
                        break;

                    case 16:
                        finish_dialogue();
                        break;

                    case 20:
                        dialogue_step = 21;
                        speaker = "Джозоф";
                        dialogue_text = "Я уже пообещал твоей дочке вернуть ее отца домой.";
                        break;

                    case 21:
                        start_dialogue_pause(
                            round(game_get_speed(gamespeed_fps)),
                            0,
                            "",
                            "",
                            true
                        );
                        break;
                }
            }
        }
        break;


    case GameState.CHOICE:
        var choice_count = array_length(choice_options);

        if (choice_count <= 0) {
            finish_dialogue();
            break;
        }

        if (keyboard_check_pressed(vk_up)) {
            choice_index -= 1;

            if (choice_index < 0) {
                choice_index = choice_count - 1;
            }
        }

        if (keyboard_check_pressed(vk_down)) {
            choice_index += 1;

            if (choice_index >= choice_count) {
                choice_index = 0;
            }
        }

        if (keyboard_check_pressed(vk_enter)) {
            last_choice_index = choice_index;

            if (dialogue_type == 2) {
                apply_daughter_choice(choice_index);
            }

            if (dialogue_type == 3) {
                apply_wife_choice(choice_index);
            }

            if (dialogue_type == 4) {
                apply_joseph_choice(choice_index);
            }

            choice_open = false;
            dialogue_open = true;

            dialogue_step = 5;
            if (dialogue_type == 4) {
                dialogue_step = 15;
            }
            speaker = "Герой";
            dialogue_text = choice_options[choice_index];

            scr_game_state_set(GameState.DIALOGUE);
        }
        break;
}
