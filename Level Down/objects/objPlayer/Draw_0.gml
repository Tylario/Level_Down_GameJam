// Glow transparency and scale modifiers for layers
var alpha_modifier = glow_alpha; // Dynamic alpha
var scale_modifier = glow_scale; // Dynamic scale

// Draw two glow sprites behind the player
if (timeSinceTouchingLowGravity > 0) {
    gpu_set_blendmode(1); // Additive blending for the glow effect

    // Glow 1 (behind, largest)
    draw_sprite_ext(
        sprPlayerGlow,
        0,
        x,
        y + 3,                     // Slightly shifted down
        scale_modifier,            // Dynamic scale
        scale_modifier,            // Dynamic scale
        0,
        c_white,
        alpha_modifier * 1.5       // Slightly brighter alpha
    );

    // Glow 2 (behind, medium size)
    draw_sprite_ext(
        sprPlayerGlow,
        0,
        x,
        y + 3,
        scale_modifier * 0.85,     // Dynamic scale reduced by 15%
        scale_modifier * 0.85,     // Dynamic scale reduced by 15%
        0,
        c_white,
        alpha_modifier             // Use dynamic alpha
    );

    gpu_set_blendmode(0); // Reset blending mode
}

// Draw the player sprite
draw_self();

// Draw two glow sprites in front of the player
if (timeSinceTouchingLowGravity > 0) {
    gpu_set_blendmode(1); // Additive blending for the glow effect

    // Glow 3 (front, smaller size)
    draw_sprite_ext(
        sprPlayerGlow,
        0,
        x,
        y + 3,
        scale_modifier * 0.7,      // Smaller scale
        scale_modifier * 0.7,      // Smaller scale
        0,
        c_white,
        alpha_modifier * 0.8       // Slightly dimmer alpha
    );

    // Glow 4 (front, smallest size)
    draw_sprite_ext(
        sprPlayerGlow,
        0,
        x,
        y + 3,
        scale_modifier * 0.55,     // Smallest scale
        scale_modifier * 0.55,     // Smallest scale
        0,
        c_white,
        alpha_modifier * 0.5       // Faintest alpha
    );

    gpu_set_blendmode(0); // Reset blending mode
}
