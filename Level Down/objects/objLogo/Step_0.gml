if (keyboard_check(vk_space) || keyboard_check(vk_up) || keyboard_check(vk_down) || 
    keyboard_check(vk_left) || keyboard_check(vk_right) || 
    keyboard_check(ord("W")) || keyboard_check(ord("A")) || 
    keyboard_check(ord("S")) || keyboard_check(ord("D"))) {
    // Flag to indicate fading should start
    global.startFading = true;
}

// If the flag is set, start decreasing the alpha
if (global.startFading) {
    image_alpha = clamp(image_alpha - (1/room_speed), 0, 1);
}