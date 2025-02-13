// Create Event for objFullScreenToggle

// Initialize global fullscreen variable if not already set
if (!variable_global_exists("fullscreen")) {
    global.fullscreen = true;  // Default to windowed mode
}

// Set initial values for hover effects
hover = false;  // Initially, the mouse is not hovering over the button

// Set the current sprite based on the fullscreen state
current_sprite = sprWindowed;


var scale = 3;
var gui_width = display_get_gui_width();
var sprite_w = sprite_get_width(current_sprite) * scale;
var sprite_h = sprite_get_height(current_sprite) * scale;
var margin = 20; // Adjusted for better visibility

var pos_x = gui_width - sprite_w - margin;
var pos_y = margin;

// Draw the sprite in the top right corner
draw_sprite_ext(sprWindowed, 0, pos_x, pos_y, scale, scale, 0, c_white, 1);

