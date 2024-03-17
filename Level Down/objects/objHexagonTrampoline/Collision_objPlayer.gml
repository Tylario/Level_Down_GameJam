if !soundPlaying {
	soundPlaying = true
	audio_play_sound(sndJump, 0, false);
	alarm[0] = 5;
}

with (objPlayer) {
	if (objPlayer.jumping == false && objPlayer.falling == false)
	{
		bounceTimer = 0.5;
		bouncing = true;
		timeSinceTouchingGround = 0.25;
	}
}