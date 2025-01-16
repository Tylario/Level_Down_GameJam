if (currentFloor == other.floorNumber && jumping == false && falling == false && bouncing == false) 
{
    // Check the state of the tile
    if (other.state == "on" || other.state == "transition_on") {
        timeSinceTouchingGround = 0.1;
    }
}
