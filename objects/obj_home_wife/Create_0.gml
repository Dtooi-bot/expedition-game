// obj_home_wife_Create.txt
// Create Event
// Полная версия Create для obj_home_wife.
// Если глобальные переменные семьи еще не созданы, запускаем scr_game_init().

if (!variable_global_exists("wife_health")) {
    scr_game_init();
}

npc_name = "Жена";
dialogue_text = "Я боюсь отпускать тебя, но понимаю, почему ты должен идти.";
interaction_distance = 72;
show_hint = false;
