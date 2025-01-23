// Increment timer
timer += 1;

// Reset timer if it exceeds the cycle time
if (timer >= time_cycle) {
    timer = timer % time_cycle;  // More conventional modulus operation
}

// Determine current state based on timer position
if (timer < transition_time) {
    state = "transition_on";
    animation_frame = lerp(0, 5, timer / transition_time);
    collision_mask = true;
}
else if (timer < transition_time + time_on) {
    state = "on";
    var local_time = timer - transition_time;

    // Calculate time limits for the fast and slow segments
    var fast_segment_end = 0.2 * time_on;  // 20% of time_on
    var slow_segment_start = fast_segment_end;
    var slow_segment_end = time_on;  // End of time_on

    if (local_time < fast_segment_end) {
        // Fast segment: Frames 6 to 16
        animation_frame = lerp(6, 16, local_time / fast_segment_end);
    } else {
        // Slow segment: Frames 17 to 27
        var slow_local_time = local_time - slow_segment_start;
        var slow_duration = slow_segment_end - slow_segment_start;
        animation_frame = lerp(17, 27, slow_local_time / slow_duration);
    }
    collision_mask = true;
}
else if (timer < 2 * transition_time + time_on) {
    state = "transition_off";
    var local_time = timer - (transition_time + time_on);
    animation_frame = lerp(28, 32, local_time / transition_time);
    collision_mask = true;
}
else {
    state = "off";
    animation_frame = 33;
    collision_mask = false;
}
