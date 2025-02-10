//door shut after player enters
self.sprite_index = sprRocketDoorClose;

var sound = sndDoorsClosing;
audio_play_sound(sound, 1, false, global.volume);

//rocket take off
alarm[1] = 100;