// obj_home_daughter
// Create Event
// Дочь находится на втором визуальном плане относительно героя.

scr_game_init();

npc_name = "Дочь";
interaction_distance = 72;
show_hint = false;

// NPC рисуется позади главного героя.
depth = -90000;
