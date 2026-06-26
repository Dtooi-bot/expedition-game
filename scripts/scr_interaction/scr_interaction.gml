// scr_interaction
// Находит только один ближайший интерактивный объект.
// Это исключает одновременное срабатывание двух NPC на одну клавишу E.

function scr_get_interaction_target(_player_id) {
    if (!instance_exists(_player_id)) {
        return noone;
    }

    var object_types = [
        obj_home_interact,
        obj_home_wife,
        obj_home_daughter,
        obj_npc_joseph
    ];

    var target = noone;
    var best_distance = 1000000000;

    for (var type_index = 0; type_index < array_length(object_types); type_index++) {
        var object_type = object_types[type_index];
        var amount = instance_number(object_type);

        for (var instance_index = 0; instance_index < amount; instance_index++) {
            var candidate = instance_find(object_type, instance_index);

            if (candidate == noone) {
                continue;
            }

            // Измеряем расстояние не до центра большого объекта,
            // а до ближайшей точки его прямоугольной границы.
            var nearest_x = clamp(_player_id.x, candidate.bbox_left, candidate.bbox_right);
            var nearest_y = clamp(_player_id.y, candidate.bbox_top, candidate.bbox_bottom);

            var candidate_distance = point_distance(
                _player_id.x,
                _player_id.y,
                nearest_x,
                nearest_y
            );

            if (
                candidate_distance <= candidate.interaction_distance
                && candidate_distance < best_distance
            ) {
                best_distance = candidate_distance;
                target = candidate;
            }
        }
    }

    return target;
}
