// obj_family_status
// Draw GUI Event
// Показывает показатели семьи только в состоянии MENU.
// Если пауза открыта поверх меню, панель остаётся под затемнением.

scr_game_state_init();

var menu_visible = (
    global.game_state == GameState.MENU
    || (
        global.game_state == GameState.PAUSE
        && global.game_state_before_pause == GameState.MENU
    )
);

if (!menu_visible) {
    exit;
}

scr_game_init();

var panel_x1 = 32;
var panel_y1 = 32;
var panel_x2 = 500;
var panel_y2 = 270;

draw_set_alpha(0.88);
draw_set_color(c_black);
draw_rectangle(panel_x1, panel_y1, panel_x2, panel_y2, false);
draw_set_alpha(1);

draw_set_color(c_white);
draw_rectangle(panel_x1, panel_y1, panel_x2, panel_y2, true);

draw_text(panel_x1 + 24, panel_y1 + 20, "СЕМЬЯ");
draw_text(panel_x1 + 24, panel_y1 + 48, "I или Escape - закрыть меню");

draw_text(panel_x1 + 24, panel_y1 + 88, "Жена");
draw_text(panel_x1 + 44, panel_y1 + 112, "Здоровье: " + string(global.wife_health));
draw_text(panel_x1 + 44, panel_y1 + 136, "Доверие: " + string(global.wife_trust));
draw_text(panel_x1 + 44, panel_y1 + 160, "Лояльность: " + string(global.wife_loyalty));

draw_text(panel_x1 + 260, panel_y1 + 88, "Дочь");
draw_text(panel_x1 + 280, panel_y1 + 112, "Здоровье: " + string(global.daughter_health));
draw_text(panel_x1 + 280, panel_y1 + 136, "Доверие: " + string(global.daughter_trust));
draw_text(panel_x1 + 280, panel_y1 + 160, "Лояльность: " + string(global.daughter_loyalty));

draw_text(panel_x1 + 24, panel_y1 + 210, "Ответ дочери: ");

var daughter_answer = "ещё не выбран";

switch (global.daughter_departure_choice) {
    case 0:
        daughter_answer = "Да.";
        break;

    case 1:
        daughter_answer = "Разбудить перед уходом.";
        break;

    case 2:
        daughter_answer = "Постараться остаться ненадолго.";
        break;
}

draw_text(panel_x1 + 150, panel_y1 + 210, daughter_answer);
