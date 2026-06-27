// obj_player
// Step Event
// Движение разрешено только в состоянии исследования.
// Для стен используем обычные place_meeting.
// Для персонажей используем ручную "зону тела" вокруг центра,
// потому что стандартные sprite collision mask не совпадают с видимым телом.

scr_game_state_init();

if (global.game_state != GameState.EXPLORE) {
    exit;
}


// --------------------------------------------------
// РУЧНАЯ ПРОВЕРКА КОЛЛИЗИИ С ПЕРСОНАЖАМИ
// --------------------------------------------------
// Почему не только place_meeting?
// У игрока, жены и дочки большие спрайты с прозрачными областями.
// Визуально тела уже пересекаются, а стандартные collision mask
// ещё могут не касаться друг друга. Поэтому для живых персонажей
// делаем отдельную круглую зону столкновения.

function actor_collision_at(_test_x, _test_y) {
    var player_radius = 34;

    // Жена
    for (var i = 0; i < instance_number(obj_home_wife); i++) {
        var wife_id = instance_find(obj_home_wife, i);

        if (wife_id != noone) {
            var wife_radius = 38;

            if (
                point_distance(
                    _test_x,
                    _test_y,
                    wife_id.x,
                    wife_id.y
                ) < player_radius + wife_radius
            ) {
                return true;
            }
        }
    }

    // Дочь
    for (var j = 0; j < instance_number(obj_home_daughter); j++) {
        var daughter_id = instance_find(obj_home_daughter, j);

        if (daughter_id != noone) {
            var daughter_radius = 34;

            if (
                point_distance(
                    _test_x,
                    _test_y,
                    daughter_id.x,
                    daughter_id.y
                ) < player_radius + daughter_radius
            ) {
                return true;
            }
        }
    }

    // Джозоф
    for (var k = 0; k < instance_number(obj_npc_joseph); k++) {
        var joseph_id = instance_find(obj_npc_joseph, k);

        if (joseph_id != noone) {
            var joseph_radius = 36;

            if (
                point_distance(
                    _test_x,
                    _test_y,
                    joseph_id.x,
                    joseph_id.y
                ) < player_radius + joseph_radius
            ) {
                return true;
            }
        }
    }

    return false;
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
// ДВИЖЕНИЕ ПО X
// --------------------------------------------------

var blocked_x = (
    place_meeting(x + hsp, y, obj_solid)
    || place_meeting(x + hsp, y, obj_home_interact)
    || actor_collision_at(x + hsp, y)
);

if (!blocked_x) {
    x += hsp;
}
else {
    while (
        hsp != 0
        && !place_meeting(x + sign(hsp), y, obj_solid)
        && !place_meeting(x + sign(hsp), y, obj_home_interact)
        && !actor_collision_at(x + sign(hsp), y)
    ) {
        x += sign(hsp);
    }
}


// --------------------------------------------------
// ДВИЖЕНИЕ ПО Y
// --------------------------------------------------

var blocked_y = (
    place_meeting(x, y + vsp, obj_solid)
    || place_meeting(x, y + vsp, obj_home_interact)
    || actor_collision_at(x, y + vsp)
);

if (!blocked_y) {
    y += vsp;
}
else {
    while (
        vsp != 0
        && !place_meeting(x, y + sign(vsp), obj_solid)
        && !place_meeting(x, y + sign(vsp), obj_home_interact)
        && !actor_collision_at(x, y + sign(vsp))
    ) {
        y += sign(vsp);
    }
}
