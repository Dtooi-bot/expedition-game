// obj_cutscene_Create.txt
// Create Event
// Полная версия для obj_cutscene.
// Контроллер первой сцены: дом, семья, первый выбор.

if (!variable_global_exists("wife_health")) {
    scr_game_init();
}

scene_step = 0;
dialogue_open = true;
choice_open = false;
choice_index = 0;

speaker = "Жена";
dialogue_text = "Ты не обязан идти. Карта может врать.";
