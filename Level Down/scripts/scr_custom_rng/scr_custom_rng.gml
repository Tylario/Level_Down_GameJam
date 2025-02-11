// Custom RNG seed
global.custom_rng_seed = 0;

// Set the seed for the custom RNG
function custom_rng_set_seed(seed) {
    global.custom_rng_seed = seed;
}

// Generate a random integer between 0 and max (exclusive)
function custom_rng_int(max) {
    // LCG parameters (common values for a 32-bit integer)
    var a = 1664525;
    var c = 1013904223;
    var m = 4294967296; // 2^32

    // Update the seed
    global.custom_rng_seed = (a * global.custom_rng_seed + c) mod m;

    // Return a random integer between 0 and max-1
    return global.custom_rng_seed mod max;
}

// Generate a random float between 0 and 1
function custom_rng_float() {
    // Generate a random integer and normalize it to a float
    var randomInt = custom_rng_int(1000000);
    return randomInt / 1000000.0;
}