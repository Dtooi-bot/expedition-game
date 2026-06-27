// obj_pub_entrance_controller
// Create Event
// Управляет сценой перед пабом:
// 0 = обычная улица
// 1 = постановочный кадр: Джозоф выкинул пьяницу
// 2 = улица после диалога, дверь открыта

scr_game_init();
scr_game_state_init();


// Важно:
// В комнате есть чёрный Background layer с depth = 100.
// depth = 50 держит фон улицы поверх чёрного слоя комнаты,
// но игрок с depth = -100000 всё равно остаётся поверх фона.
depth = 50;

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


// Позиция героя на постановочном кадре с Джозофом.
// Герой видим, но фиксируется на месте,
// чтобы не ходить поверх нарисованных Джозофа и пьяницы.
joseph_scene_player_x = 590;
joseph_scene_player_y = 440;


// Куда вернуть игрока после постановочного кадра.
player_return_x = 650;
player_return_y = 520;


// Чтобы диалог на второй картинке не запускался несколько раз.
joseph_dialogue_requested = false;


// На второй сцене герой больше не скрывается.
// Он остаётся видимым и ставится в постановочную позицию.
var player_id = instance_find(obj_player, 0);

if (player_id != noone) {
    player_id.visible = true;

    if (current_stage == 1) {
        player_id.x = joseph_scene_player_x;
        player_id.y = joseph_scene_player_y;
    }
}
