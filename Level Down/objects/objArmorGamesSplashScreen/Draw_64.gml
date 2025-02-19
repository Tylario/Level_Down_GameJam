/// @desc Draw GUI - Splash Screen Animation (Full Screen)

if (sprite_exists(sprArmorGamesAnimation)) {
    var screen_w = display_get_gui_width();   // Get screen width
    var screen_h = display_get_gui_height();  // Get screen height
    var sprite_w = sprite_get_width(sprArmorGamesAnimation);  // Get sprite width
    var sprite_h = sprite_get_height(sprArmorGamesAnimation); // Get sprite height

    // Calculate scale factors to match the screen
    var scale_x = screen_w / sprite_w;
    var scale_y = screen_h / sprite_h;

    // Draw the sprite stretched to fit the screen
    draw_sprite_ext(sprArmorGamesAnimation, image_index, 0, 0, scale_x, scale_y, 0, c_white, 1);
}
