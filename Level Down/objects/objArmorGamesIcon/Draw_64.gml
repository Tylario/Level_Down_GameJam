/// @desc Draw GUI - Clickable Image in Top Right Corner
var img_w = (80 / 4) * 2; // Scale up to twice the previous size
var img_h = (119 / 4) * 2; // Scale up to twice the previous size
var img_x = display_get_gui_width() - img_w - 10; // Position in top-right with 10px padding
var img_y = 10; // 10px padding from top

// Draw the image
if (sprite_exists(sprArmorGames)) {
    draw_sprite_ext(sprArmorGames, 0, img_x, img_y, 0.5, 0.5, 0, c_white, 1);
}

// Get correct mouse position for GUI layer
var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);

// Check for mouse release on image (better for web builds)
if (mouse_check_button_released(mb_left)) {
    if (mx > img_x && mx < img_x + img_w && my > img_y && my < img_y + img_h) {
        url_open("https://armor.ag/MoreGames");
    }
}
