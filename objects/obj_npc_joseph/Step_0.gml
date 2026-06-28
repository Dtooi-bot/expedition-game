// obj_npc_joseph
// Step Event
// В обычных сценах Джозоф говорит простую реплику.
// Внутри паба запускается отдельный большой диалог.

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
            if (room == rm_pub_interior) {
                dialogue_controller.start_joseph_pub_interior_dialogue();
            }
            else {
                dialogue_controller.start_simple_dialogue(
                    npc_name,
                    dialogue_text
                );
            }
        }
    }
}
