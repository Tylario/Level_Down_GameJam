if (currentFloor == other.floorNumber && jumping == false && falling == false && bouncing == false) 
{
	timeSinceTouchingGround = 0.1;
	iceTime = 0.1;
	other.alarm[1] = 1;
}
