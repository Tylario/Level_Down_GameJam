if (other.floorNumber == currentFloor) {
    timeSinceTouchingGround = 0.25;

	arrowDirection = other.arrowDirection;
	
	show_debug_message(arrowDirection + string(irandom(10)))

	
    var moveAmount = 4;

    switch(arrowDirection) {
        case "Up":
            y -= moveAmount;
            break;
        case "Up Right":
            y -= moveAmount * 0.7071; 
            x += moveAmount * 0.7071;
            break;
        case "Down Right":
            y += moveAmount * 0.7071;
            x += moveAmount * 0.7071;
            break;
        case "Down":
            y += moveAmount;
            break;
        case "Down Left":
            y += moveAmount * 0.7071;
            x -= moveAmount * 0.7071;
            break;
        case "Up Left":
            y -= moveAmount * 0.7071; 
            x -= moveAmount * 0.7071;
            break;
    }
}
