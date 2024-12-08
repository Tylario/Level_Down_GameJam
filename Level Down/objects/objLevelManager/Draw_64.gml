draw_set_font(fntHabbo);
draw_set_valign(fa_top);
draw_set_halign(fa_left);
draw_set_color(c_white);

if (keyboard_check(vk_escape) && !keyboard_check(ord("R"))) {	
	draw_text_transformed(18, 50, "Quitting...", 3, 3, 0);
}

if (keyboard_check(ord("R")) && !keyboard_check(vk_escape)) {
	draw_text_transformed(18, 50, "Resetting...", 3, 3, 0);
}