// Define a temporary flag at the beginning of the collision event
var validCollision = false;

with (objPlayer) 
{
	if (not jumping and not bouncing and not falling and arrowJumpingTimer >= arrowJumpTime)
	{
	    // Assuming the map's width and a midpoint can determine the correct side
	    var mapMidpoint = room_width / 2;

	    // Determine side based on currentFloor: even floors (0, 2, 4...) use one side, odd floors (1, 3, 5...) use the other
	    var correctSide = (currentFloor % 2 == 0) ? (x < mapMidpoint) : (x > mapMidpoint);

	    if (jumping == false && falling == false && correctSide) {
	        bounceTimer = 0.5;
	        bouncing = true;
	        timeSinceTouchingGround = 1;
	        // Indicate a valid collision has occurred
	        validCollision = true;
	    }
	}
}

// Check the flag after evaluating the collision conditions
if (validCollision && !soundPlaying) {
    soundPlaying = true;
    audio_play_sound(sndJump, 0, false);
    alarm[0] = 5;
}
