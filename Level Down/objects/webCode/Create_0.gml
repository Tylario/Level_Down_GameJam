// Set the game resolution
global.game_width = 960; // Fixed width
global.game_height = 540; // Fixed height

// Resize the application surface to match the fixed resolution
surface_resize(application_surface, global.game_width, global.game_height);

// Ensure the GUI matches the resolution
display_set_gui_size(global.game_width, global.game_height);

// Debugging information
show_debug_message("Game initialized with fixed resolution: " + string(global.game_width) + "x" + string(global.game_height));
// Disable fullscreen scaling behavior
