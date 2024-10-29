// Decrease the countdown based on delta_time (initialize `countdown` to 0.5 elsewhere)
countdown -= delta_time / 1000000; // Convert delta_time from microseconds to seconds

// When countdown reaches zero or below, trigger alarm[0]
if (countdown <= 0) {
    alarm[0] = 1; // Set alarm[0] to trigger on the next frame
} else {
    alarm[1] = 1; // Re-trigger alarm[1] to keep counting down
}
