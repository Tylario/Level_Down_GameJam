if (other.floorNumber == currentFloor and jumping == false and falling == false and bouncing == false) {
    timeSinceTouchingGround = 0.25;

	if (arrowJumpingTimer > arrowJumpTime)
	{
		arrowJumpingTimer = 0;
		arrowDirection = other.arrowDirection;
	}
}
