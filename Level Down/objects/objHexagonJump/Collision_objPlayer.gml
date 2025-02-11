if (other.currentFloor == floorNumber && objPlayer.jumping == false && objPlayer.falling == false && objPlayer.bouncing == false) 
{
	other.timeSinceTouchingGround = 0.1;
	other.jumpWhileTouchingJump = true;
	other.jumpTimer = 0;
	other.jumping = true;
	audio_play_sound(sndBoing, 1, false, global.volume);
	
	// Collision Event with objPlayer
	if (!animating) {  // Check if the animation is not already playing
	    animating = true;
		image_index = 1;
		alarm[5] = room_speed * 0.1;
	}
}

