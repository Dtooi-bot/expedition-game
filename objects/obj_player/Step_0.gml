// obj_player_Step.txt

var move_x = keyboard_check(ord("D")) - keyboard_check(ord("A"));
var move_y = keyboard_check(ord("S")) - keyboard_check(ord("W"));

x += move_x * move_speed;
y += move_y * move_speed;