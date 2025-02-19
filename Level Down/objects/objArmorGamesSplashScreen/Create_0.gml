/// @desc Initialize splash screen
image_speed = 126 / 5 / room_speed; // Adjust animation speed to last 5 seconds
audio_play_sound(sndArmorGames, 1, false); // Play the sound once
alarm[0] = 5 * room_speed; // Set alarm to destroy object after 5 seconds
