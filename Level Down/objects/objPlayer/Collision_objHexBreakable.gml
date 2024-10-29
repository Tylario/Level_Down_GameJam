if (currentFloor == other.floorNumber && jumping == false && falling == false && bouncing == false) 
{
	other.timeTouchingPlayer += delta_time / 1000000;
	timeSinceTouchingGround = 0.1;
	if (other.timeTouchingPlayer > 0)
	{
		other.timeUntilBreak -= delta_time / 1000000
		if (other.timeUntilBreak <= 0)
		{
			other.alarm[0] = 1;
		}
	}
}
