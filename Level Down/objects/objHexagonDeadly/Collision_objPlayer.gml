if (other.currentFloor == floorNumber && objPlayer.jumping == false && objPlayer.falling == false && objPlayer.bouncing == false) 
{
	timeTouchingPlayer = timeTouchingPlayer + delta_time / 1000000;
	other.timeSinceTouchingGround = -0.1;
	//room_restart()
}