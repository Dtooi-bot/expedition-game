// obj_player_Step.txt
// Step Event
// Полная версия Step для obj_player.
// Движение WASD + столкновения с obj_solid и obj_home_interact.

var move_x = keyboard_check(ord("D")) - keyboard_check(ord("A"));
var move_y = keyboard_check(ord("S")) - keyboard_check(ord("W"));

if (move_x != 0 && move_y != 0) {
    move_x *= 0.7071;
    move_y *= 0.7071;
}

var hsp = move_x * move_speed;
var vsp = move_y * move_speed;

// Движение по X
if (!place_meeting(x + hsp, y, obj_solid) && !place_meeting(x + hsp, y, obj_home_interact)) {
    x += hsp;
}
else {
    while (
        hsp != 0
        && !place_meeting(x + sign(hsp), y, obj_solid)
        && !place_meeting(x + sign(hsp), y, obj_home_interact)
    ) {
        x += sign(hsp);
    }
}

// Движение по Y
if (!place_meeting(x, y + vsp, obj_solid) && !place_meeting(x, y + vsp, obj_home_interact)) {
    y += vsp;
}
else {
    while (
        vsp != 0
        && !place_meeting(x, y + sign(vsp), obj_solid)
        && !place_meeting(x, y + sign(vsp), obj_home_interact)
    ) {
        y += sign(vsp);
    }
}
