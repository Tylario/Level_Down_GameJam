// Define a temporary flag at the beginning of the collision event
var validCollision = false;
var floorNum = floorNumber;
var xPosition = x + 15;
var yPosition = y;

with (objPlayer) 
{
    if (not jumping and not bouncing and not falling and arrowJumpingTimer >= arrowJumpTime and floorNum == currentFloor)
    {
        bounceTimer = 0.5;
        bouncing = true;
        timeSinceTouchingGround = 1.5;
        // Indicate a valid collision has occurred
        validCollision = true;

        // Create particle effect here, setting depth lower than objPlayer
        // Assuming objPlayer's depth is set to something like 100
        var particle = instance_create_depth(xPosition, yPosition, depth - 1, objParticleEffect);
		particle.startingX = xPosition;
		particle.startingY = yPosition;
    }
}

// Check the flag after evaluating the collision conditions
if (validCollision && !soundPlaying) {
    soundPlaying = true;
    audio_play_sound(sndUpArrow, 0, false, global.volume);
    alarm[0] = 5;
}
