if (timeSinceTouchingGround <= 0)
{
	falling = true;
	timeSinceTouchingGround = 0.25;
	//show_debug_message("player falling");
}