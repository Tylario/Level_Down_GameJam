with (objPlayer) {
	if (objPlayer.jumping == false && objPlayer.falling == false)
	{
		bounceTimer = 0.5;
		bouncing = true;
		timeSinceTouchingGround = 0.25;
	}
}