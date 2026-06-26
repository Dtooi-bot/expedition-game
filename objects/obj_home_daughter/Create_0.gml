// obj_home_daughter_Create.txt
// Create Event
// Полная версия Create для obj_home_daughter.
// Если глобальные переменные семьи еще не созданы, запускаем scr_game_init().

if (!variable_global_exists("daughter_health")) {
    scr_game_init();
}

npc_name = "Дочь";
dialogue_text = "Папа, ты правда привезешь мне ракушку?";
interaction_distance = 72;
show_hint = false;
