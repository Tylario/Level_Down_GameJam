if (!touched) {
    // Start the animation countdown only if it hasn’t been touched yet
    touched = true;
    countdown = 2;          // Total countdown time of 2 seconds (0.5 second animation + 1.5 second wait)
    spriteIndex = 0;        // Start at the first frame of the animation sequence
    alarm[1] = 1;           // Re-trigger alarm[1] on the next frame
} else {
    // Decrement countdown over time
    countdown -= 1 / room_speed;

    // Animate over the first 0.5 seconds
    if (countdown > 1.5) {
        // Calculate frames per second to fit 7 frames into 0.5 seconds
        var framesPerSecond = 14;  // 7 frames over 0.5 seconds
        spriteIndex = min(floor((2 - countdown) * framesPerSecond), 6);

        // Update the sprite based on spriteIndex
        switch (spriteIndex) {
            case 0: sprite_index = sprHexagonHardIce; break;
            case 1: sprite_index = sprHexagonHardIce2; break;
            case 2: sprite_index = sprHexagonHardIce3; break;
            case 3: sprite_index = sprHexagonHardIce4; break;
            case 4: sprite_index = sprHexagonHardIce5; break;
            case 5: sprite_index = sprHexagonHardIce6; break;
            case 6: sprite_index = sprHexagonHardIce7; break;
        }
    }

    // When countdown reaches 1.5 seconds (0.5 seconds elapsed), stop animating and start waiting
    if (countdown <= 1.5 && countdown > 0) {
        sprite_index = sprHexagonHardIce7; // Keep the last frame during the wait period
    }

    // After 2 seconds total (0.5-second animation + 1.5-second wait), start falling
    if (countdown <= 0) {
        alarm[0] = 1;  // Trigger the fall
    } else {
        alarm[1] = 1;  // Continue the countdown
    }
}
