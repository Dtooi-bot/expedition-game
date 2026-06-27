// obj_cutscene
// Step Event
// Управляет репликами, паузой с тремя точками, выбором ответа
// и временем жизни плашки отношений.


// --------------------------------------------------
// ТАЙМЕР ПЛАШКИ ОТНОШЕНИЙ
// --------------------------------------------------
// Он работает даже после закрытия диалога,
// чтобы уведомление могло исчезнуть уже в режиме исследования.

if (relation_popup_active) {
    relation_popup_timer -= 1;

    if (relation_popup_timer <= 0) {
        relation_popup_timer = 0;
        relation_popup_active = false;
    }
}


if (!active) {
    exit;
}

scr_game_state_init();


// Во время общей паузы диалог остаётся на экране,
// но его внутреннее состояние не изменяется.
if (global.game_state == GameState.PAUSE) {
    exit;
}


switch (global.game_state) {
    case GameState.DIALOGUE:
        // Настоящая пауза после фразы дочери.
        if (pause_frames > 0) {
            pause_frames -= 1;

            if (pause_frames <= 0) {
                dialogue_step = 4;
                speaker = "Дочь";
                dialogue_text = "Когда я проснусь, ты уже уйдешь?";
            }

            break;
        }

        if (keyboard_check_pressed(vk_enter)) {
            // Обычная одиночная реплика закрывается по Enter.
            if (dialogue_type == 1) {
                finish_dialogue();
                break;
            }

            // Диалог с дочерью.
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
                        dialogue_text = "Ты всегда так говоришь.";
                        break;

                    case 2:
                        dialogue_step = 3;
                        speaker = "";
                        dialogue_text = "...";

                        // Одна секунда автоматической тишины.
                        pause_frames = max(
                            1,
                            round(game_get_speed(gamespeed_fps))
                        );
                        break;

                    case 4:
                        dialogue_open = false;
                        choice_open = true;
                        choice_index = 0;
                        scr_game_state_set(GameState.CHOICE);
                        break;

                    case 5:
                        finish_dialogue();
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
            apply_daughter_choice(choice_index);

            choice_open = false;
            dialogue_open = true;

            dialogue_step = 5;
            speaker = "Герой";
            dialogue_text = choice_options[choice_index];

            scr_game_state_set(GameState.DIALOGUE);
        }
        break;
}
