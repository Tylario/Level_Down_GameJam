// Define a temporary flag at the beginning of the collision event
var validCollision = false;
var floorNum = floorNumber

with (objPlayer) 
{
	if (not jumping and not bouncing and not falling and arrowJumpingTimer >= arrowJumpTime and floorNum == currentFloor)
	{

	        bounceTimer = 0.5;
	        bouncing = true;
	        timeSinceTouchingGround = 1.5;
	        // Indicate a valid collision has occurred
	        validCollision = true;
	}
}

// Check the flag after evaluating the collision conditions
if (validCollision && !soundPlaying) {
    soundPlaying = true;
    audio_play_sound(sndJump, 0, false);
    alarm[0] = 5;
}
