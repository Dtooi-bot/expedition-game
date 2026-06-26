// obj_cutscene_Step.txt
// Step Event
// Полная версия для obj_cutscene.
// Space / Enter - продолжить диалог.
// W/S или Up/Down - выбор.
// Enter - подтвердить выбор.

if (dialogue_open) {
    if (keyboard_check_pressed(vk_space) || keyboard_check_pressed(vk_enter)) {
        scene_step += 1;

        if (scene_step == 1) {
            speaker = "Герой";
            dialogue_text = "Если я останусь, мы просто будем ждать конца.";
        }
        else if (scene_step == 2) {
            speaker = "Жена";
            dialogue_text = "А если море заберет тебя раньше болезни?";
        }
        else if (scene_step == 3) {
            speaker = "Дочь";
            dialogue_text = "Ты привезешь мне ракушку?";
        }
        else if (scene_step == 4) {
            speaker = "Герой";
            dialogue_text = "Привезу. И лекарство тоже.";
        }
        else if (scene_step == 5) {
            speaker = "Жена";
            dialogue_text = "Тогда реши, что делать с деньгами. Нам они тоже нужны.";
        }
        else if (scene_step == 6) {
            dialogue_open = false;
            choice_open = true;
            choice_index = 0;
        }
    }
}

if (choice_open) {
    if (keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W"))) {
        choice_index = 0;
    }

    if (keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S"))) {
        choice_index = 1;
    }

    if (keyboard_check_pressed(vk_enter)) {
        if (choice_index == 0) {
            scr_apply_family_money_choice(true);
        }
        else {
            scr_apply_family_money_choice(false);
        }

        room_goto(rm_ship);
    }
}
