// obj_pub_interior_controller
// Create Event
// Контроллер статичного интерьера паба.

scr_game_init();
scr_game_state_init();

global.location_map_active = false;
scr_game_state_set(GameState.EXPLORE);

depth = 1000000;
