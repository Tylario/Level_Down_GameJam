/// Step Event

// Increment timer
timer += 1;

// Reset timer if it exceeds the cycle time
if (timer >= time_cycle) {
    timer -= time_cycle; // Equivalent to `timer %= time_cycle`
}

// Determine current state based on timer position
if (timer < transition_time) {
    state = "transition_on";
    animation_frame = lerp(1, 5, timer / transition_time); // Transition from frame 1 to 5
    collision_mask = true; // Enable collision
} 
else if (timer < transition_time + time_on) {
    state = "on";
    animation_frame = 5; // Fully on
    collision_mask = true;
} 
else if (timer < 2 * transition_time + time_on) {
    state = "transition_off";
    var local_time = timer - (transition_time + time_on);
    animation_frame = lerp(5, 11, local_time / transition_time); // Transition from frame 5 to 11
    collision_mask = true; // Enable collision during transition
} 
else {
    state = "off";
    animation_frame = 11; // Fully off
    collision_mask = false; // Disable collision
}
