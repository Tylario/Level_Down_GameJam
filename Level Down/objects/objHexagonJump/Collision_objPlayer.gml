if (other.currentFloor == floorNumber && objPlayer.jumping == false && objPlayer.falling == false && objPlayer.bouncing == false) 
{
	other.timeSinceTouchingGround = 0.1;
	other.jumpWhileTouchingJump = true;
	other.jumpTimer = 0;
	other.jumping = true;
	audio_play_sound(sndBoing, 1, false, global.volume);
}