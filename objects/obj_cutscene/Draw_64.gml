// obj_cutscene
// Draw GUI Event
// Нижняя диалоговая панель и варианты ответа.
draw_set_font(fnt_ui_cyrillic);

if (!active) {
    exit;
}

var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();

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
