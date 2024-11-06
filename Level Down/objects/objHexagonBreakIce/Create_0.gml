// Initialize variables
touched = false;           // Whether the tile has been touched
countdown = 2;             // Delay in seconds before the fall starts after being touched
spriteIndex = 0;           // For sprite cycling (optional)
spriteCycleTime = 2 / 7;   // Time between sprite frames if needed
alarm[1] = -1;             // Alarm[1] is initially inactive
alarm[0] = -1;             // Alarm[0] is initially inactive
