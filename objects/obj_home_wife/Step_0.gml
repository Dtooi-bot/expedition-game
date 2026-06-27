// obj_home_wife
// Step Event
// Запускает диалог с женой только по нажатию E.
// Сам диалог хранится в obj_cutscene.

show_hint = false;

if (!scr_game_state_is(GameState.EXPLORE)) {
    exit;
}

var player_id = instance_find(obj_player, 0);

if (player_id == noone) {
    exit;
}

var target = scr_get_interaction_target(player_id);

if (target == id) {
    show_hint = true;

    if (keyboard_check_pressed(ord("E"))) {
        var dialogue_controller = instance_find(obj_cutscene, 0);

        if (dialogue_controller != noone) {
            dialogue_controller.start_wife_dialogue();
        }
    }
}
