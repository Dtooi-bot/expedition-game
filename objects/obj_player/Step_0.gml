// obj_player
// Step Event
// Движение разрешено только в состоянии исследования.
// Коллизия с женой и дочкой теперь снова идёт через place_meeting,
// чтобы ты мог вручную настраивать их Collision Mask в GameMaker.

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
// ДВИЖЕНИЕ ПО X
// --------------------------------------------------

var blocked_x = (
    place_meeting(x + hsp, y, obj_solid)
    || place_meeting(x + hsp, y, obj_home_interact)
    || place_meeting(x + hsp, y, obj_home_wife)
    || place_meeting(x + hsp, y, obj_home_daughter)
    || place_meeting(x + hsp, y, obj_npc_joseph)
);

if (!blocked_x) {
    x += hsp;
}
else {
    while (
        hsp != 0
        && !place_meeting(x + sign(hsp), y, obj_solid)
        && !place_meeting(x + sign(hsp), y, obj_home_interact)
        && !place_meeting(x + sign(hsp), y, obj_home_wife)
        && !place_meeting(x + sign(hsp), y, obj_home_daughter)
        && !place_meeting(x + sign(hsp), y, obj_npc_joseph)
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
    || place_meeting(x, y + vsp, obj_home_wife)
    || place_meeting(x, y + vsp, obj_home_daughter)
    || place_meeting(x, y + vsp, obj_npc_joseph)
);

if (!blocked_y) {
    y += vsp;
}
else {
    while (
        vsp != 0
        && !place_meeting(x, y + sign(vsp), obj_solid)
        && !place_meeting(x, y + sign(vsp), obj_home_interact)
        && !place_meeting(x, y + sign(vsp), obj_home_wife)
        && !place_meeting(x, y + sign(vsp), obj_home_daughter)
        && !place_meeting(x, y + sign(vsp), obj_npc_joseph)
    ) {
        y += sign(vsp);
    }
}
