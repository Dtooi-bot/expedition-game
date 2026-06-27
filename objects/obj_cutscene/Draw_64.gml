// obj_cutscene
// Draw GUI Event
// Нижняя диалоговая панель, варианты ответа,
// плашки отношений и затемнение перед переходом.

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
        if (pause_frames <= 0 && final_question_timer <= 0) {
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

    var col_bar_back = make_color_rgb(10, 13, 16);
    var col_bar_border = make_color_rgb(3, 5, 7);

    var col_trust = make_color_rgb(42, 155, 225);
    var col_loyalty = make_color_rgb(225, 176, 20);

    var col_green = make_color_rgb(92, 220, 56);
    var col_red = make_color_rgb(230, 55, 45);

    var trust_percent = clamp(relation_popup_trust_value, 0, 100);
    var loyalty_percent = clamp(relation_popup_loyalty_value, 0, 100);


    // --------------------------------------------------
    // 2.1. КРАСИВАЯ ПЛАШКА ДОЧЕРИ
    // --------------------------------------------------

    if (relation_popup_character_name == "Дочь") {
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
        var trust_bar_x = popup_x + 306 * popup_scale;
        var trust_bar_y = popup_y + 220 * popup_scale;

        var loyalty_bar_x = popup_x + 306 * popup_scale;
        var loyalty_bar_y = popup_y + 326 * popup_scale;

        var bar_w = 462 * popup_scale;
        var bar_h = 34 * popup_scale;

        var trust_delta_x = popup_x + 790 * popup_scale;
        var trust_delta_y = popup_y + 216 * popup_scale;

        var loyalty_delta_x = popup_x + 790 * popup_scale;
        var loyalty_delta_y = popup_y + 326 * popup_scale;


        // Шкала доверия.
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


        // Шкала лояльности.
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


        // Изменение доверия.
        if (relation_popup_trust_delta != 0) {
            var trust_delta_text = string(relation_popup_trust_delta);

            if (relation_popup_trust_delta > 0) {
                trust_delta_text = "+" + string(relation_popup_trust_delta);
                draw_set_color(col_green);
            }
            else {
                draw_set_color(col_red);
            }

            draw_set_halign(fa_left);
            draw_set_valign(fa_middle);

            draw_text_transformed(
                trust_delta_x,
                trust_delta_y,
                trust_delta_text,
                popup_scale * 1.7,
                popup_scale * 1.7,
                0
            );
        }


        // Изменение лояльности.
        if (relation_popup_loyalty_delta != 0) {
            var loyalty_delta_text = string(relation_popup_loyalty_delta);

            if (relation_popup_loyalty_delta > 0) {
                loyalty_delta_text = "+" + string(relation_popup_loyalty_delta);
                draw_set_color(col_green);
            }
            else {
                draw_set_color(col_red);
            }

            draw_set_halign(fa_left);
            draw_set_valign(fa_middle);

            draw_text_transformed(
                loyalty_delta_x,
                loyalty_delta_y,
                loyalty_delta_text,
                popup_scale * 1.7,
                popup_scale * 1.7,
                0
            );
        }

        draw_set_alpha(1);
    }


    // --------------------------------------------------
    // 2.2. ВРЕМЕННАЯ ТЕКСТОВАЯ ПЛАШКА ДЛЯ ЖЕНЫ
    // --------------------------------------------------
    // Для жены пока нет отдельного арта плашки.
    // Поэтому изменения показываются простым GUI-блоком.

    else {
        var box_w = 440;
        var box_h = 190;
        var box_x = gui_w - box_w - 24;
        var box_y = 24;

        draw_set_alpha(0.86 * popup_alpha);
        draw_set_color(c_black);
        draw_rectangle(box_x, box_y, box_x + box_w, box_y + box_h, false);

        draw_set_alpha(popup_alpha);
        draw_set_color(c_white);
        draw_rectangle(box_x, box_y, box_x + box_w, box_y + box_h, true);

        draw_set_font(fnt_ui_cyrillic);
        draw_set_halign(fa_left);
        draw_set_valign(fa_top);

        draw_text(box_x + 24, box_y + 18, relation_popup_character_name);

        var trust_y = box_y + 68;
        var loyalty_y = box_y + 126;

        draw_set_color(c_white);
        draw_text(box_x + 24, trust_y, "Доверие");
        draw_text(box_x + 24, loyalty_y, "Лояльность");

        var bar_x = box_x + 160;
        var bar_w = 150;
        var bar_h = 14;

        draw_set_color(col_bar_back);
        draw_rectangle(bar_x, trust_y + 6, bar_x + bar_w, trust_y + 6 + bar_h, false);
        draw_rectangle(bar_x, loyalty_y + 6, bar_x + bar_w, loyalty_y + 6 + bar_h, false);

        draw_set_color(col_trust);
        draw_rectangle(
            bar_x + 2,
            trust_y + 8,
            bar_x + 2 + (bar_w - 4) * trust_percent / 100,
            trust_y + 6 + bar_h - 2,
            false
        );

        draw_set_color(col_loyalty);
        draw_rectangle(
            bar_x + 2,
            loyalty_y + 8,
            bar_x + 2 + (bar_w - 4) * loyalty_percent / 100,
            loyalty_y + 6 + bar_h - 2,
            false
        );

        // Изменение доверия жены.
        if (relation_popup_trust_delta != 0) {
            var wife_trust_delta_text = string(relation_popup_trust_delta);

            if (relation_popup_trust_delta > 0) {
                wife_trust_delta_text = "+" + string(relation_popup_trust_delta);
                draw_set_color(col_green);
            }
            else {
                draw_set_color(col_red);
            }

            draw_text(box_x + 330, trust_y - 2, wife_trust_delta_text);
        }

        // Изменение лояльности жены.
        if (relation_popup_loyalty_delta != 0) {
            var wife_loyalty_delta_text = string(relation_popup_loyalty_delta);

            if (relation_popup_loyalty_delta > 0) {
                wife_loyalty_delta_text = "+" + string(relation_popup_loyalty_delta);
                draw_set_color(col_green);
            }
            else {
                draw_set_color(col_red);
            }

            draw_text(box_x + 330, loyalty_y - 2, wife_loyalty_delta_text);
        }

        draw_set_alpha(1);
    }
}


// --------------------------------------------------
// 3. ЗАТЕМНЕНИЕ ПЕРЕД ГАВАНЬЮ
// --------------------------------------------------

if (fade_active) {
    draw_set_alpha(clamp(fade_alpha, 0, 1));
    draw_set_color(c_black);
    draw_rectangle(0, 0, gui_w, gui_h, false);
    draw_set_alpha(1);
}


// --------------------------------------------------
// 4. СБРОС НАСТРОЕК РИСОВАНИЯ
// --------------------------------------------------

draw_set_alpha(1);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
