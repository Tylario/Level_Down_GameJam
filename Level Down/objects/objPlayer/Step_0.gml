arrowMultiplier = 1;

var movingLeft = keyboard_check(vk_left) || keyboard_check(ord("A"));
var movingRight = keyboard_check(vk_right) || keyboard_check(ord("D"));
var movingUp = keyboard_check(vk_up) || keyboard_check(ord("W"));
var movingDown = keyboard_check(vk_down) || keyboard_check(ord("S"));
var jumpingPressed = keyboard_check(vk_space);

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
	var moveAmount = 0.47 / arrowJumpTime;
    
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

// Initialize a variable for the last direction in the Create Event
// Possible values: "left", "right", "up", "down", "upLeft", "upRight", "downLeft", "downRight"
lastDirection = "none";

// Update the lastDirection based on movement (in the Step Event)
if (xMomentum < 0) {
    lastDirection = "left";
} else if (xMomentum > 0) {
    lastDirection = "right";
}

if (yMomentum < 0) {
    if (lastDirection == "left") {
        lastDirection = "upLeft";
    } else if (lastDirection == "right") {
        lastDirection = "upRight";
    } else {
        lastDirection = "up";
    }
} else if (yMomentum > 0) {
    if (lastDirection == "left") {
        lastDirection = "downLeft";
    } else if (lastDirection == "right") {
        lastDirection = "downRight";
    } else {
        lastDirection = "down";
    }
}

// Decide whether the player is moving
var isMoving = xMomentum != 0 || yMomentum != 0;

// Select the correct sprite based on movement and direction
if (isMoving) {
    switch(lastDirection) {
        case "left":
            sprite_index = sprWalkLeft;
            break;
        case "right":
            sprite_index = sprWalkRight;
            break;
        case "up":
            sprite_index = sprWalkUp;
            break;
        case "down":
            sprite_index = sprWalkDown;
            break;
        case "upLeft":
            sprite_index = sprWalkUpLeft;
            break;
        case "upRight":
            sprite_index = sprWalkUpRight;
            break;
        case "downLeft":
            sprite_index = sprWalkDownLeft;
            break;
        case "downRight":
            sprite_index = sprWalkDownRight;
            break;
    }
} else {
    // When not moving, switch to the corresponding idle sprite
    switch(lastDirection) {
        case "left":
            sprite_index = sprLeftIdle;
            break;
        case "right":
            sprite_index = sprRightIdle;
            break;
        case "up":
            sprite_index = sprUpIdle;
            break;
        case "down":
            sprite_index = sprDownIdle;
            break;
        case "upLeft":
            sprite_index = sprUpLeftIdle;
            break;
        case "upRight":
            sprite_index = sprUpRightIdle;
            break;
        case "downLeft":
            sprite_index = sprDownLeftIdle;
            break;
        case "downRight":
            sprite_index = sprDownRightIdle;
            break;
        default:
            // Optional: Decide on a default idle sprite if no direction is set
            sprite_index = sprDownIdle; // Example default
            break;
    }
}

// Adjust image_speed for animations
image_speed = isMoving ? 0.5 : 0; // Set this according to your game's needs


//jumping
jumpTimer = jumpTimer + delta_time / 1000000;

if (jumpingPressed and jumpTimer > 0.75)
{
	jumpTimer = 0;
}

if (jumpTimer > 0 and jumpTimer < 0.5)
{
	jumping = true;
	y = y + ((jumpTimer - 0.25) * 25);
	//set sprite equal to one of 6 directions, starting at the direction relative to current facing should appear to rotate
}
else
{
	jumping = false
}

