// obj_home_wife
// Create Event
// Жена находится на втором визуальном плане относительно героя.

scr_game_init();

npc_name = "Жена";
dialogue_text = "Я боюсь отпускать тебя, но понимаю, почему ты должен идти.";
interaction_distance = 100;
show_hint = false;

// NPC рисуется позади главного героя.
depth = -90000;
