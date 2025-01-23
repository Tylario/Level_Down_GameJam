// Decrement collision_timer if greater than 0
if (collision_timer > 0) {
    collision_timer -= delta_time / 1000000; // Frame-independent timer decrement
    
    // Set the animation speed to transition frames upward
    animation_speed = 0.25;
    
    // Increment the sprite frame based on animation speed
    sprite_frame += animation_speed;
    
    // Clamp the sprite frame to the maximum (frame 4 for 0-based index)
    if (sprite_frame > 4) {
        sprite_frame = 4;
    }
} else {
    // Handle decrement when collision_timer is less than 0
    frame_decrement_timer += delta_time / 100000; // Accumulate elapsed time

    if (frame_decrement_timer >= 0.5) { // Only decrement 1 frame per second
        if (sprite_frame > 0) {
            sprite_frame -= 1;
        }
        frame_decrement_timer = 0; // Reset timer for the next frame change
    }

    // Clamp the sprite frame to the minimum (frame 0)
    if (sprite_frame < 0) {
        sprite_frame = 0;
    }
}

// Update the sprite index frame based on the calculated value
image_index = sprite_frame;
