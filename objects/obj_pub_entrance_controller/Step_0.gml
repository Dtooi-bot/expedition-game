// obj_pub_entrance_controller
// Step Event
// Переключает картинки улицы, запускает диалог с Джозофом
// и впускает игрока в паб.

scr_game_init();
scr_game_state_init();

global.location_map_active = false;

var player_id = instance_find(obj_player, 0);
var cutscene_id = instance_find(obj_cutscene, 0);


// Игрок скрыт только во время постановочного кадра с Джозофом.
if (player_id != noone) {
    if (current_stage == 1) {
        player_id.visible = false;
    }
    else {
        player_id.visible = true;
    }
}


// --------------------------------------------------
// ЛОКАЛЬНОЕ ЗАТЕМНЕНИЕ МЕЖДУ КАДРАМИ
// --------------------------------------------------

if (fade_active_local) {
    fade_alpha_local += fade_speed_local;

    if (fade_alpha_local >= 1) {
        fade_alpha_local = 1;
        fade_active_local = false;

        switch (fade_action) {
            case 1:
                current_stage = 1;
                global.pub_street_phase = 1;
                joseph_dialogue_requested = false;

                if (player_id != noone) {
                    player_id.visible = false;
                }

                scr_game_state_set(GameState.EXPLORE);
                break;


            case 2:
                current_stage = 2;
                global.pub_street_phase = 2;

                if (player_id != noone) {
                    player_id.visible = true;
                    player_id.x = player_return_x;
                    player_id.y = player_return_y;
                }

                scr_game_state_set(GameState.EXPLORE);
                break;


            case 3:
                global.location_map_active = false;
                scr_game_state_set(GameState.EXPLORE);

                var room_id = asset_get_index("rm_pub_interior");

                if (room_id != -1) {
                    room_goto(room_id);
                }
                else {
                    // Запасной переход, чтобы проект не падал,
                    // если rm_pub_interior ещё не создана.
                    room_goto(rm_harbor);
                }
                break;
        }
    }

    exit;
}


// --------------------------------------------------
// СТАДИЯ 1: ПОСТАНОВОЧНЫЙ КАДР С ДЖОЗОФОМ
// --------------------------------------------------
// Джозоф здесь не объект. Он часть статичной картинки.
// Поэтому игрок нажимает E, а контроллер запускает диалог.

if (current_stage == 1) {
    show_door_hint = false;
    show_scene_hint = false;

    if (!scr_game_state_is(GameState.EXPLORE)) {
        exit;
    }

    if (
        !global.joseph_pub_choice_done
        && !joseph_dialogue_requested
    ) {
        show_scene_hint = true;

        if (keyboard_check_pressed(ord("E"))) {
            joseph_dialogue_requested = true;

            if (cutscene_id != noone) {
                cutscene_id.start_joseph_pub_dialogue();
            }
        }

        exit;
    }


    if (
        global.joseph_pub_choice_done
        && cutscene_id != noone
        && !cutscene_id.active
    ) {
        fade_action = 2;
        fade_alpha_local = 0;
        fade_active_local = true;
        scr_game_state_set(GameState.DIALOGUE);
    }

    exit;
}


// --------------------------------------------------
// СТАДИЯ 0 И 2: ВЗАИМОДЕЙСТВИЕ С ДВЕРЬЮ ПАБА
// --------------------------------------------------

show_door_hint = false;
show_scene_hint = false;

if (!scr_game_state_is(GameState.EXPLORE)) {
    exit;
}

if (player_id == noone) {
    exit;
}

var near_door = point_distance(
    player_id.x,
    player_id.y,
    door_x,
    door_y
) <= door_radius;

if (near_door) {
    show_door_hint = true;

    if (keyboard_check_pressed(ord("E"))) {
        if (current_stage == 0) {
            fade_action = 1;
            fade_alpha_local = 0;
            fade_active_local = true;
            scr_game_state_set(GameState.DIALOGUE);
        }
        else if (current_stage == 2) {
            fade_action = 3;
            fade_alpha_local = 0;
            fade_active_local = true;
            scr_game_state_set(GameState.DIALOGUE);
        }
    }
}
