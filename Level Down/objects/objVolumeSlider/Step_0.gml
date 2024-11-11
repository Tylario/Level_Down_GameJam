// Check for mouse press and initiate dragging
if (mouse_check_button_pressed(mb_left)) {
    // Calculate the center of the handle
    var handle_center_x = handle_x + handle_width / 2;
    var handle_center_y = y + height / 2;  // This places the center in the middle of the bar's height

    // Get mouse coordinates in GUI layer
    var mouse_x_gui = device_mouse_x_to_gui(0);
    var mouse_y_gui = device_mouse_y_to_gui(0);

    // Check if the mouse is within the radius of the handle
    if (point_distance(mouse_x_gui, mouse_y_gui, handle_center_x, handle_center_y) <= handle_height / 2) {  // Use half of handle_height as the radius
        dragging = true;
        offset_x = mouse_x_gui - handle_x;
    }
}

// Handle dragging logic
if (dragging) {
    if (mouse_check_button(mb_left)) {
        var mouse_x_gui = device_mouse_x_to_gui(0);
        // Update handle_x within the slider boundaries and considering the handle's radius
        handle_x = clamp(mouse_x_gui - offset_x, x, x + width - handle_width);
        global.volume = (handle_x - x) / width;
		audio_sound_gain(sndBlakeSoundtrack, global.volume, 0);
		// Write new volume to file
        ini_open("settings.ini");
        ini_write_real("Audio", "Volume", global.volume);
        ini_close();
    } else {
        dragging = false;
    }
}
