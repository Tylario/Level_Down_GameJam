// Get the browser window dimensions
var window_width = display_get_width();
var window_height = display_get_height();

// Apply the fixed resolution
display_set_gui_size(global.game_width, global.game_height);
surface_resize(application_surface, global.game_width, global.game_height);

// Prevent the window from resizing dynamically
if (window_width != global.game_width || window_height != global.game_height) {
    // Optionally log or debug this case
    show_debug_message("Window size does not match fixed resolution. Forcing fixed resolution.");
}
