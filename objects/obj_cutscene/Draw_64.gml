// obj_cutscene
// Draw GUI Event
// Нижняя диалоговая панель, варианты ответа
// и временная плашка изменения отношений.

draw_set_font(fnt_ui_cyrillic);

var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();


// --------------------------------------------------
// 1. ДИАЛОГОВОЕ ОКНО
// --------------------------------------------------

if (active) {
    var panel_x1 = 32;
    var panel_x2 = gui_w - 32;
    var panel_y2 = gui_h - 32;

    var panel_height = 200;

    if (choice_open) {
        panel_height = 340;
    }

    var panel_y1 = panel_y2 - panel_height;


    // Фон
    draw_set_alpha(0.88);
    draw_set_color(c_black);
    draw_rectangle(panel_x1, panel_y1, panel_x2, panel_y2, false);
    draw_set_alpha(1);

    // Тонкая рамка
    draw_set_color(c_white);
    draw_rectangle(panel_x1, panel_y1, panel_x2, panel_y2, true);

    draw_set_halign(fa_left);
    draw_set_valign(fa_top);


    // Имя говорящего
    if (speaker != "") {
        draw_text(panel_x1 + 24, panel_y1 + 18, speaker);
    }


    // Реплика
    draw_text_ext(
        panel_x1 + 24,
        panel_y1 + 52,
        dialogue_text,
        24,
        panel_x2 - panel_x1 - 48
    );


    // Варианты ответа
    if (choice_open) {
        var option_y = panel_y1 + 115;
        var option_gap = 58;

        for (var i = 0; i < array_length(choice_options); i++) {
            var prefix = "  ";

            if (i == choice_index) {
                prefix = "> ";
            }

            draw_text_ext(
                panel_x1 + 24,
                option_y + i * option_gap,
                prefix + choice_options[i],
                22,
                panel_x2 - panel_x1 - 48
            );
        }

        draw_text(
            panel_x1 + 24,
            panel_y2 - 28,
            "Стрелки вверх / вниз - выбрать    Enter - подтвердить"
        );
    }
    else {
        // Во время автоматической паузы подсказку не показываем.
        if (pause_frames <= 0) {
            draw_text(
                panel_x1 + 24,
                panel_y2 - 28,
                "Enter - продолжить"
            );
        }
    }
}


// --------------------------------------------------
// 2. ВСПЛЫВАЮЩАЯ ПЛАШКА ОТНОШЕНИЙ
// --------------------------------------------------

if (relation_popup_active) {
    // Плавное исчезновение в последние 30 кадров.
    var popup_alpha = 1;

    if (relation_popup_timer < 30) {
        popup_alpha = relation_popup_timer / 30;
    }

    var popup_scale = relation_popup_scale;

    var popup_w = sprite_get_width(spr_ui_daughter_relation_popup) * popup_scale;
    var popup_h = sprite_get_height(spr_ui_daughter_relation_popup) * popup_scale;

    var popup_x = gui_w - popup_w - relation_popup_margin_x;
    var popup_y = relation_popup_margin_y;


    // Фон-плашка.
    draw_set_alpha(popup_alpha);
    draw_set_color(c_white);

    draw_sprite_ext(
        spr_ui_daughter_relation_popup,
        0,
        popup_x,
        popup_y,
        popup_scale,
        popup_scale,
        0,
        c_white,
        popup_alpha
    );


    // Координаты внутри исходного спрайта плашки.
    // Спрайт сделан из картинки 958x428.
    var trust_bar_x = popup_x + 306 * popup_scale;
    var trust_bar_y = popup_y + 184 * popup_scale;

    var loyalty_bar_x = popup_x + 306 * popup_scale;
    var loyalty_bar_y = popup_y + 326 * popup_scale;

    var bar_w = 462 * popup_scale;
    var bar_h = 34 * popup_scale;

    var trust_delta_x = popup_x + 790 * popup_scale;
    var trust_delta_y = popup_y + 182 * popup_scale;

    var loyalty_delta_x = popup_x + 790 * popup_scale;
    var loyalty_delta_y = popup_y + 326 * popup_scale;


    // Цвета
    var col_bar_back = make_color_rgb(10, 13, 16);
    var col_bar_border = make_color_rgb(3, 5, 7);

    var col_trust = make_color_rgb(42, 155, 225);
    var col_loyalty = make_color_rgb(225, 176, 20);

    var col_green = make_color_rgb(92, 220, 56);
    var col_red = make_color_rgb(230, 55, 45);

    var col_delta = col_green;

    if (relation_popup_trust_delta < 0) {
        col_delta = col_red;
    }


    // Рисуем шкалу доверия.
    var trust_percent = clamp(relation_popup_trust_value, 0, 100);

    draw_set_color(col_bar_back);
    draw_rectangle(
        trust_bar_x,
        trust_bar_y,
        trust_bar_x + bar_w,
        trust_bar_y + bar_h,
        false
    );

    draw_set_color(col_trust);
    draw_rectangle(
        trust_bar_x + 3 * popup_scale,
        trust_bar_y + 3 * popup_scale,
        trust_bar_x + 3 * popup_scale + (bar_w - 6 * popup_scale) * trust_percent / 100,
        trust_bar_y + bar_h - 3 * popup_scale,
        false
    );

    draw_set_color(col_bar_border);
    draw_rectangle(
        trust_bar_x,
        trust_bar_y,
        trust_bar_x + bar_w,
        trust_bar_y + bar_h,
        true
    );


    // Рисуем шкалу лояльности.
    var loyalty_percent = clamp(relation_popup_loyalty_value, 0, 100);

    draw_set_color(col_bar_back);
    draw_rectangle(
        loyalty_bar_x,
        loyalty_bar_y,
        loyalty_bar_x + bar_w,
        loyalty_bar_y + bar_h,
        false
    );

    draw_set_color(col_loyalty);
    draw_rectangle(
        loyalty_bar_x + 3 * popup_scale,
        loyalty_bar_y + 3 * popup_scale,
        loyalty_bar_x + 3 * popup_scale + (bar_w - 6 * popup_scale) * loyalty_percent / 100,
        loyalty_bar_y + bar_h - 3 * popup_scale,
        false
    );

    draw_set_color(col_bar_border);
    draw_rectangle(
        loyalty_bar_x,
        loyalty_bar_y,
        loyalty_bar_x + bar_w,
        loyalty_bar_y + bar_h,
        true
    );


    // Текст изменения доверия.
    if (relation_popup_trust_delta != 0) {
        var delta_text = "";

        if (relation_popup_trust_delta > 0) {
            delta_text = "+" + string(relation_popup_trust_delta);
        }
        else {
            delta_text = string(relation_popup_trust_delta);
        }

        draw_set_font(fnt_ui_cyrillic);
        draw_set_halign(fa_left);
        draw_set_valign(fa_middle);
        draw_set_color(col_delta);

        draw_text_transformed(
            trust_delta_x,
            trust_delta_y,
            delta_text,
            popup_scale * 1.7,
            popup_scale * 1.7,
            0
        );


        // Стрелка вверх или вниз рядом с числом.
        var arrow_x = trust_delta_x + 75 * popup_scale;
        var arrow_y = trust_delta_y;

        draw_set_color(col_delta);

        if (relation_popup_trust_delta > 0) {
            draw_triangle(
                arrow_x,
                arrow_y - 26 * popup_scale,
                arrow_x - 15 * popup_scale,
                arrow_y + 2 * popup_scale,
                arrow_x + 15 * popup_scale,
                arrow_y + 2 * popup_scale,
                false
            );

            draw_rectangle(
                arrow_x - 6 * popup_scale,
                arrow_y,
                arrow_x + 6 * popup_scale,
                arrow_y + 28 * popup_scale,
                false
            );
        }
        else {
            draw_triangle(
                arrow_x,
                arrow_y + 28 * popup_scale,
                arrow_x - 15 * popup_scale,
                arrow_y,
                arrow_x + 15 * popup_scale,
                arrow_y,
                false
            );

            draw_rectangle(
                arrow_x - 6 * popup_scale,
                arrow_y - 26 * popup_scale,
                arrow_x + 6 * popup_scale,
                arrow_y + 2 * popup_scale,
                false
            );
        }
    }


    // Лояльность сейчас не меняем, поэтому здесь ничего не пишем.
    // Когда появятся выборы, влияющие на лояльность,
    // можно будет вывести relation_popup_loyalty_delta у loyalty_delta_x/y.

    draw_set_alpha(1);
}


// --------------------------------------------------
// 3. СБРОС НАСТРОЕК РИСОВАНИЯ
// --------------------------------------------------

draw_set_alpha(1);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
