// obj_cutscene_family_Create.txt
// Create Event
// Контроллер первой сцены: дом, семья, первый выбор.

scene_step = 0;
dialogue_open = true;
choice_open = false;
choice_index = 0;

speaker = "Мать";
dialogue_text = "Ты не обязан идти. Карта может врать.";

global.start_gold = 300;
global.family_money_left = false;
global.expedition_gold = global.start_gold;
