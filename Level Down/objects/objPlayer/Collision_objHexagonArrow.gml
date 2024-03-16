if (other.floorNumber == currentFloor) {
    timeSinceTouchingGround = 0.25;

	if (arrowJumpingTimer > arrowJumpTime)
	{
		arrowJumpingTimer = 0;
		arrowDirection = other.arrowDirection;
	}
}
