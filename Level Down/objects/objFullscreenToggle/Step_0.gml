// Step Event for objFullScreenToggle

// Get mouse coordinates in GUI layer
var mouse_x_gui = device_mouse_x_to_gui(0);
var mouse_y_gui = device_mouse_y_to_gui(0);

// Calculate scaled dimensions and positions for click detection
var scale = hover ? 3.2 : 3;  // Apply hover scale if hovering
var gui_width = display_get_gui_width();
var sprite_w = sprite_get_width(current_sprite) * scale;
var sprite_h = sprite_get_height(current_sprite) * scale;
var margin = 20;

var button_x = gui_width - sprite_w - margin;
var button_y = margin;

// Define the hitbox for the toggle button
var button_rect_x1 = button_x;
var button_rect_y1 = button_y;
var button_rect_x2 = button_x + sprite_w;
var button_rect_y2 = button_y + sprite_h;

// Check for mouse hover
hover = (mouse_x_gui >= button_rect_x1 && mouse_x_gui <= button_rect_x2 && mouse_y_gui >= button_rect_y1 && mouse_y_gui <= button_rect_y2);

// If hovering, possibly handle clicks
if (hover) {
    // Toggle fullscreen on click
    if (mouse_check_button_pressed(mb_left)) {
        global.fullscreen = !global.fullscreen;
        window_set_fullscreen(global.fullscreen);
    }
}
