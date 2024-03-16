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

x = x + clamp(xMomentum, -maxSpeed, maxSpeed);
y = y + clamp(yMomentum, -maxSpeed, maxSpeed) * 0.71; // this 0.71 is  to consider the 45 degree angle

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