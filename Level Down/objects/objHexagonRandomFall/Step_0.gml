timeSinceSpawn += delta_time / 1000000

if (timeSinceSpawn > randomTime)
{
	sprite_index = sprHexagonWarning;
	if (timeSinceSpawn  > randomTime + 2)
	{
		breaking = true;
	}
}

if (breaking)
{
    fallingTime -= delta_time / 1000000;
    
    if (fallingTime <= 0)
    {
        instance_destroy();
    }
    else
	{
		//as it falls, accelerate down
	    var seconds = delta_time / 1000000;
	    currentSpeed += fallingAcceleration * seconds;
	    y += currentSpeed;
		
		//as it falls, it becomes more transparent
	    var alphaDecreasePerStep = 1 / fallingTime * seconds;
	    image_alpha -= alphaDecreasePerStep;
	    image_alpha = max(image_alpha, 0);
	}
}
