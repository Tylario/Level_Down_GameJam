arrowMultiplier = 1;

var movingLeft = keyboard_check(vk_left);
var movingRight = keyboard_check(vk_right);
var movingUp = keyboard_check(vk_up);
var movingDown = keyboard_check(vk_down);

// horizontal movement 
if (movingLeft xor movingRight) { 
    if (movingLeft) {
        xMomentum = xMomentum - acceleration;
        if (xMomentum < -maxSpeed) {
            xMomentum = -maxSpeed;
        }
    } else if (movingRight) {
        xMomentum = xMomentum + acceleration;
        if (xMomentum > maxSpeed) {
            xMomentum = maxSpeed;
        }
    }
} else {
    // decelerate when neither or both left and right keys are pressed
    if (xMomentum > 0) {
        xMomentum = xMomentum - acceleration;
        if (xMomentum < 0) {
            xMomentum = 0;
        }
    } else if (xMomentum < 0) {
        xMomentum = xMomentum + acceleration;
        if (xMomentum > 0) {
            xMomentum = 0;
        }
    }
}

// vertical movement
if (movingUp xor movingDown) { 
    if (movingUp) {
        yMomentum = yMomentum - acceleration;
        if (yMomentum < -maxSpeed) {
            yMomentum = -maxSpeed;
        }
    } else if (movingDown) {
        yMomentum = yMomentum + acceleration;
        if (yMomentum > maxSpeed) {
            yMomentum = maxSpeed;
        }
    }
} else {
    // decelerate when neither or both up and down keys are pressed
    if (yMomentum > 0) {
        yMomentum = yMomentum - acceleration;
        if (yMomentum < 0) {
            yMomentum = 0;
        }
    } else if (yMomentum < 0) {
        yMomentum = yMomentum + acceleration;
        if (yMomentum > 0) {
            yMomentum = 0;
        }
    }
}


if ((movingUp || movingDown) && (movingLeft || movingRight)) {
    var combinedSpeed = sqrt(xMomentum * xMomentum + yMomentum * yMomentum);
    var diagonalSpeedCap = maxSpeed * 0.71; // Adjust the cap for diagonal movement

    if (combinedSpeed > diagonalSpeedCap) {
        // Calculate the ratio to scale down the momentum to the diagonal cap
        var scaleRatio = diagonalSpeedCap / combinedSpeed;
        xMomentum = xMomentum * scaleRatio;
        yMomentum = yMomentum * scaleRatio;
    }
}

// Reset timer if not falling

timeSinceTouchingGround = timeSinceTouchingGround - (delta_time / 1000000);


// ice tile
iceTime = iceTime - (delta_time / 1000000);

if (iceTime > 0)
{
	acceleration = 0.15;
}
else
{
	acceleration = 16;
}

// Arrow tiles
arrowJumpingTimer += delta_time / 1000000;
if (arrowJumpingTimer >= 0 && arrowJumpingTimer <= arrowJumpTime)
{
    var someValue = 3; // Define the scale of the jump effect
    var jumpEffect = someValue * (((-2 * arrowJumpingTimer) / arrowJumpTime) + 1); // Calculate the jump effect
	var moveAmount = 0.43 / arrowJumpTime;
    
    switch(arrowDirection) {
        case "Up": // Directly up
            y -= moveAmount;
            break;
        case "Up Right":  // Approx 28 degrees
            y -= moveAmount * 0.46947; // Adjusted for demonstration
            x += moveAmount * 0.88295; // Adjusted for demonstration
            break;
        case "Down Right": // Approx -28 degrees
            y += moveAmount * 0.46947; // Adjusted for demonstration
            x += moveAmount * 0.88295; // Adjusted for demonstration
            break;
        case "Down": // Straight down
            y += moveAmount;
            break;	 
        case "Down Left": // Approx 180 + 28 degrees
            y += moveAmount * 0.46947; // Adjusted for demonstration
            x -= moveAmount * 0.88295; // Adjusted for demonstration
            break;
        case "Up Left": // Approx 180 - 28 degrees
            y -= moveAmount * 0.46947; // Adjusted for demonstration
            x -= moveAmount * 0.88295; // Adjusted for demonstration
            break;
    }
    
    // Implementing the jump effect
    y -= jumpEffect;

	arrowMultiplier = 0.3;
}
else
{
	arrowMultiplier = 1;
}

x = x + clamp(xMomentum, -maxSpeed, maxSpeed) * arrowMultiplier;
y = y + clamp(yMomentum, -maxSpeed, maxSpeed) * arrowMultiplier; // this 0.71 is  to consider the 45 degree angle

