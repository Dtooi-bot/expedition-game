// obj_family_status_Draw_GUI.txt
// Draw GUI Event
// Необязательный объект для отладки.
// Создай obj_family_status и поставь его в rm_ship, чтобы видеть последствия выбора после перехода на корабль.

draw_set_color(c_white);

draw_text(24, 24, "СЕМЬЯ");
draw_text(24, 48, "Жена: здоровье " + string(global.wife_health) + " | доверие " + string(global.wife_trust) + " | лояльность " + string(global.wife_loyalty));
draw_text(24, 72, "Дочь: здоровье " + string(global.daughter_health) + " | доверие " + string(global.daughter_trust) + " | лояльность " + string(global.daughter_loyalty));

draw_text(24, 112, "ЭКСПЕДИЦИЯ");
draw_text(24, 136, "Золото: " + string(global.expedition_gold));
draw_text(24, 160, "Еда: " + string(global.food) + " | Дерево: " + string(global.wood) + " | Ром: " + string(global.rum) + " | Порох: " + string(global.gunpowder));
