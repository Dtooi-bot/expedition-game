// obj_family_status
// Create Event
// Меню отношений теперь использует статичный арт,
// а динамические значения рисуются кодом поверх него.

scr_game_init();
scr_game_state_init();


// Размер исходной картинки, по которой размечены координаты.
// Нужен для понимания, почему координаты в Draw GUI такие.
// Сам код берёт реальный размер через sprite_get_width / sprite_get_height.
menu_source_width = 1402;
menu_source_height = 1122;


// Невидимая зона клика по кнопке "Закрыть".
// Координаты указаны в системе исходной картинки меню.
close_button_x1 = 578;
close_button_y1 = 1000;
close_button_x2 = 824;
close_button_y2 = 1066;
