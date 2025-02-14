//show win sprite
if (showWinSprite == true) {
	//draw_sprite_ext(sprYouWin, 0, 960, 400, 6, 6, 0, c_white, 1);

}

//can restart
draw_set_font(fntHabbo);
draw_set_valign(fa_top);
draw_set_halign(fa_center);
draw_set_color(c_white);

if (canRestart == true) {
	draw_text_transformed(960, 750, "Press \"Z\" to restart", 4, 4, 0);
}
