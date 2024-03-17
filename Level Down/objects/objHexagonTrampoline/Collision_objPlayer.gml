//play jump sound only once
alarm[1] = 120;
if !soundPlaying {
	audio_play_sound(sndTrampoline, 0, false);
	soundPlaying = true;
}

with (objPlayer) {
	if (objPlayer.jumping == false && objPlayer.falling == false)
	{
		bounceTimer = 0.5;
		bouncing = true;
		timeSinceTouchingGround = 0.25;
	}
}