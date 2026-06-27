// obj_player
// Step Event
// Движение разрешено только в состоянии исследования.
// Коллизия работает через place_meeting.
// Для мебели в пабе добавлены obj_bar_counter и obj_table_and_chairs.

scr_game_state_init();

if (global.game_state != GameState.EXPLORE) {
    exit;
}


// --------------------------------------------------
// ВВОД
// --------------------------------------------------

var move_x = keyboard_check(ord("D")) - keyboard_check(ord("A"));
var move_y = keyboard_check(ord("S")) - keyboard_check(ord("W"));

if (move_x != 0 && move_y != 0) {
    move_x *= 0.7071;
    move_y *= 0.7071;
}

var hsp = move_x * move_speed;
var vsp = move_y * move_speed;


// --------------------------------------------------
// ПРОВЕРКА БЛОКИРОВКИ
// --------------------------------------------------
// Здесь собраны все объекты, через которые игрок не должен проходить.
// Важно: place_meeting использует Collision Mask этих объектов.
// Поэтому для стойки и столов/стульев маску нужно подогнать вручную
// в настройках соответствующих спрайтов.

function player_blocked_at(_test_x, _test_y) {
    return (
        place_meeting(_test_x, _test_y, obj_solid)
        || place_meeting(_test_x, _test_y, obj_home_interact)
        || place_meeting(_test_x, _test_y, obj_home_wife)
        || place_meeting(_test_x, _test_y, obj_home_daughter)
        || place_meeting(_test_x, _test_y, obj_npc_joseph)

        // Паб
        || place_meeting(_test_x, _test_y, obj_bar_counter)
        || place_meeting(_test_x, _test_y, obj_table_and_chairs)
    );
}


// --------------------------------------------------
// ДВИЖЕНИЕ ПО X
// --------------------------------------------------

var blocked_x = player_blocked_at(x + hsp, y);

if (!blocked_x) {
    x += hsp;
}
else {
    while (
        hsp != 0
        && !player_blocked_at(x + sign(hsp), y)
    ) {
        x += sign(hsp);
    }
}


// --------------------------------------------------
// ДВИЖЕНИЕ ПО Y
// --------------------------------------------------

var blocked_y = player_blocked_at(x, y + vsp);

if (!blocked_y) {
    y += vsp;
}
else {
    while (
        vsp != 0
        && !player_blocked_at(x, y + sign(vsp))
    ) {
        y += sign(vsp);
    }
}
