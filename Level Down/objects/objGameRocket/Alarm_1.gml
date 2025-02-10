//ship takes off
flying = true;

self.sprite_index = sprRocketIgnite;

var sound = sndRocketEngine;
var sound_id = audio_play_sound(sound, 1, false);
audio_sound_pitch(sound_id, 0.75); // Lower the pitch to half its original

// Set the global volume for this sound instance
audio_sound_gain(sound_id, global.volume, 0);

//show win message
alarm[2] = 30;