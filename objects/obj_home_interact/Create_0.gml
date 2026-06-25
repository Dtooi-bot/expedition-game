// obj_home_interact_Create.txt
// Create Event
// Полная версия Create для obj_home_interact.
// Объект остается интерактивным и твердым, но саму белую зону мы не рисуем.

interact_title = "Старая книга со сказками";
interact_text = "Люсия часто просит меня почитать ей.";
interaction_distance = 35;
show_hint = false;

// ВАЖНО:
// visible должен быть true, иначе Draw Event может не отрисовать подсказку E.
// Сам объект мы не рисуем, потому что в Draw Event нет draw_self().
visible = true;
