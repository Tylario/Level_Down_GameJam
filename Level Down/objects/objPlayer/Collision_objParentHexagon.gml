if (currentFloor == other.floorNumber && jumping == false && falling == false && bouncing == false) 
{
	other.timeTouchingPlayer += delta_time / 1000000;
	timeSinceTouchingGround = 0.1;
}