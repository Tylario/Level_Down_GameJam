//having a child collision event will overwrite the parent, so we'll need to include this v for any hexagon tiles that we have collision code for
if (other.floorNumber == currentFloor) 
{
	iceTime = 0.3;
    timeSinceTouchingGround = 0.25;
}
