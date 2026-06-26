// obj_family_status_Create.txt
// Create Event
// Полная версия для obj_family_status.
// Меню отношений открывается и закрывается по кнопке I.

if (!variable_global_exists("wife_health")) {
    scr_game_init();
}

family_menu_open = false;
