if (other.floorNumber == currentFloor and jumping == false and falling == false and bouncing == false) 
{
	if (arrowJumpingTimer > arrowJumpTime)
	{
		arrowJumpingTimer = 0;
		arrowDirection = other.arrowDirection;
		other.parent_arrow.desaturateSprite()
		 audio_play_sound(sndArrowBounce, 0, false, global.volume);
	}
}
