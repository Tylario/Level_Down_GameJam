// Draw GUI Event for objFullScreenToggle

// Update current sprite based on fullscreen state and hover
current_sprite = global.fullscreen ? sprWindowed : sprFullScreen;

// Get GUI dimensions and adjust sprite size based on hover
var gui_width = display_get_gui_width();
var sprite_w = sprite_get_width(current_sprite) * (hover ? 3.2 : 3);
var sprite_h = sprite_get_height(current_sprite) * (hover ? 3.2 : 3);
var margin = 20; // Increased margin for better visibility

// Calculate position for top right corner
var pos_x = gui_width - sprite_w - margin;
var pos_y = margin;

// Draw the sprite at the calculated position with adjusted scaling
draw_sprite_ext(current_sprite, 0, pos_x, pos_y, hover ? 3.2 : 3, hover ? 3.2 : 3, 0, c_white, 1);
