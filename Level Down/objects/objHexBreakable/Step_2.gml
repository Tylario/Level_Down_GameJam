if (timeTouchingPlayer > 0)
{
	timeUntilBreak = timeUntilBreak - delta_time / 1000000;
	if (timeUntilBreak <= 0)
	{
		breaking = true;
	}
}