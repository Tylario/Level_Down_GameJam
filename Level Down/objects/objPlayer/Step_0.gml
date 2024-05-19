// Update the accumulator with delta time converted to seconds
accumulator += delta_time / 1000000;

// Handle game logic updates at a fixed time step
while (accumulator >= fixed_time_step) {
    updatePhysics();
    accumulator -= fixed_time_step;
}
