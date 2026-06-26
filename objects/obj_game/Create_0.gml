// obj_game
// Create Event
// Главный постоянный контроллер игры.

// Если постоянный obj_game уже пришёл из прошлой комнаты,
// новый комнатный экземпляр уничтожается.
if (instance_number(obj_game) > 1) {
    instance_destroy();
    exit;
}

persistent = true;

// Низкая глубина означает, что интерфейс паузы рисуется поверх остальных GUI.
depth = -100000;

scr_game_init();
scr_game_state_init();
