if (breaking)
{
    fallingTime -= delta_time;
    
    if (fallingTime <= 0)
    {
        instance_destroy();
    }
    else
    {
        var seconds = delta_time / 1000000;
        y += fallingAcceleration * seconds;
    }
}