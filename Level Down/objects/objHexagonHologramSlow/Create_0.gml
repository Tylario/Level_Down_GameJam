/// Create Event
// Settings
x_range = 300; // Horizontal range
y_range = 200; // Vertical range
scale = 0.04;  // Scale for Perlin noise (adjust for desired smoothness)

time_on = 4 * room_speed;       // Time the tile stays fully on
time_off = 3 * room_speed;       // Time the tile stays fully off
transition_time = 0.25 * room_speed; // Time for each transition
time_cycle = time_on + time_off + 2 * transition_time; // Total cycle time

animation_frame = 1; // Starting animation frame
animation_speed = 0; // Adjusted dynamically
state = "off";       // Default state
collision_mask = false; // Default collision disabled

// Calculate position-based timer offset
var x_mod = x % x_range;
var y_mod = y % y_range;

// Normalize position value to [0, 1]
var position_value = (x_mod / x_range + y_mod / y_range) / 2;

// Calculate Perlin noise based on position
var perlin_value = perlin_noise(x * scale, y * scale, 0);

// Normalize Perlin noise to [0, 1] smoothly
perlin_value = clamp((perlin_value + 1) / 2, 0, 1);

// Combine position-based offset and Perlin noise
// Optionally weight them to prioritize one over the other
var combined_value = lerp(position_value, perlin_value, 0.5); // Equal blend for smoothness

// Distribute timer start based on combined value
timer = combined_value * time_cycle;
