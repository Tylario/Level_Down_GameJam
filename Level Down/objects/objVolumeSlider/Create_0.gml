// Slider settings
x = 50; // Adjust based on your UI layout
y = 30;
width = 200; // Width of the slider
height = 7; // Height of the slider bar

// Handle settings
handle_width = 20; // Width of the handle
handle_height = 20; // Height of the handle

// Load volume from file
ini_open("settings.ini");
global.volume = ini_read_real("Audio", "Volume", 0.5); // Default to 0.5 if not found
ini_close();

// Interaction variables
dragging = false;
offset_x = 0;

// Apply the loaded volume
audio_play_sound(sndBlakeMusic, 0, true);
audio_sound_gain(sndBlakeMusic, global.volume, 0);

// Adjust handle position to match loaded volume
handle_x = x + (width - handle_width) * global.volume;