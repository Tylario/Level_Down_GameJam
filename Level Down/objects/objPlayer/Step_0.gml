// Update the accumulator with delta time converted to seconds
accumulator += delta_time / 1000000;

// Handle game logic updates at a fixed time step
if ((gameEnd == false) && accumulator >= fixed_time_step) {
    updatePhysics();
    while (accumulator >= fixed_time_step)
	{
		accumulator -= fixed_time_step;
	}
}

//remove movement control for end game cutscene
if (gameEnd == true) {
	sprite_index = -1;
	objShadow.sprite_index = -1;
}