show_debug_message(other.floorNumber)

if (other.floorNumber == currentFloor and jumping == false and falling == false and bouncing == false) 
{
	if (arrowJumpingTimer > arrowJumpTime)
	{
		arrowJumpingTimer = 0;
		arrowDirection = other.arrowDirection;
	}
}
