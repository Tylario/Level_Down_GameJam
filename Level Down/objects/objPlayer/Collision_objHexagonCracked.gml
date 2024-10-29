if (currentFloor == other.floorNumber && jumping == false && falling == false && bouncing == false) 
{
	other.timeTouchingPlayer += delta_time / 1000000;
	other.alarm[0] = 1;
}
