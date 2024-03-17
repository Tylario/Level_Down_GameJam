if (other.currentFloor == floorNumber && objPlayer.jumping == false && objPlayer.falling == false) 
{
	timeTouchingPlayer = timeTouchingPlayer + delta_time / 1000000;
	other.timeSinceTouchingGround = 0.1;
}