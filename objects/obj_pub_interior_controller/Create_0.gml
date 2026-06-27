// obj_pub_entrance_controller
// Create Event
// Управляет сценой перед пабом:
// 0 = обычная улица
// 1 = постановочный кадр: Джозоф выкинул пьяницу
// 2 = улица после диалога, дверь открыта

scr_game_init();
scr_game_state_init();

depth = 1000000;
global.location_map_active = false;


// Если контроллер диалогов не пришёл из предыдущих комнат,
// создаём его здесь. Это нужно для прямого теста rm_pub_entrance.
if (!instance_exists(obj_cutscene)) {
    instance_create_depth(0, 0, -90000, obj_cutscene);
}


current_stage = global.pub_street_phase;

if (current_stage < 0 || current_stage > 2) {
    current_stage = 0;
    global.pub_street_phase = 0;
}


show_door_hint = false;
show_scene_hint = false;


// Локальное затемнение между кадрами.
fade_active_local = false;
fade_alpha_local = 0;
fade_speed_local = 1 / 30;

fade_action = 0;
// 1 = перейти к сцене Джозофа
// 2 = перейти к третьей картинке
// 3 = войти в паб


// Точка двери в комнате.
// Это не объект двери, а невидимая точка взаимодействия.
door_x = 520;
door_y = 420;
door_radius = 125;


// Куда вернуть игрока после постановочного кадра.
player_return_x = 650;
player_return_y = 520;


// Чтобы диалог на второй картинке не запускался несколько раз.
joseph_dialogue_requested = false;


// Если игрок уже пришёл на постановочный кадр,
// скрываем его, потому что Джозоф и пьяница нарисованы на фоне.
var player_id = instance_find(obj_player, 0);

if (player_id != noone) {
    if (current_stage == 1) {
        player_id.visible = false;
    }
    else {
        player_id.visible = true;
    }
}
