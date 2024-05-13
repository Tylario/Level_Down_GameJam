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
if (not jumping)
{
	timeSinceTouchingGround = timeSinceTouchingGround - (delta_time / 1000000);
}

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
	var moveAmount = 0.7 / arrowJumpTime;
    
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

if (bouncing)
{
	bouncingMultiplier = 0.3;
}
else
{
	bouncingMultiplier = 1;
}


// Calculate potential new positions
var newX = x + clamp(xMomentum, -maxSpeed, maxSpeed) * arrowMultiplier * bouncingMultiplier;
var newY = y + clamp(yMomentum, -maxSpeed, maxSpeed) * arrowMultiplier * bouncingMultiplier;

// Check for collisions at the new positions
if (currentFloor!= 0 or (!place_meeting(newX, y, objHexagonTall) && !place_meeting(x, newY, objHexagonTall))) {
    // No collision with objHexagonTall at new positions, so it's safe to move
    x = newX;
    y = newY;
} else {
    // Optional: handle the collision, e.g., stop movement, bounce back, etc.
}

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
            image_speed = 1; // Ensure animation plays while moving
            break;
        case "right":
            sprite_index = sprWalkRight;
            image_speed = 1; // Ensure animation plays while moving
            break;
        case "up":
            sprite_index = sprWalkUp;
            image_speed = 1; // Ensure animation plays while moving
            break;
        case "down":
            sprite_index = sprWalkDown;
            image_speed = 1; // Ensure animation plays while moving
            break;
        case "upLeft":
            sprite_index = sprWalkUpLeft;
            image_speed = 1; // Ensure animation plays while moving
            break;
        case "upRight":
            sprite_index = sprWalkUpRight;
            image_speed = 1; // Ensure animation plays while moving
            break;
        case "downLeft":
            sprite_index = sprWalkDownLeft;
            image_speed = 1; // Ensure animation plays while moving
            break;
        case "downRight":
            sprite_index = sprWalkDownRight;
            image_speed = 1; // Ensure animation plays while moving
            break;
    }
} else {
    // When not moving, ensure the sprite is set to the first frame of the idle animation
    image_speed = 0; // Stop the animation
    image_index = 0; // Reset to the first frame
    
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
            // Handle a default case if necessary
            break;
    }
}


// Adjust image_speed for animations
image_speed = isMoving ? 0.5 : 0; // Set this according to your game's needs


//jumping
jumpTimer = jumpTimer + delta_time / 1000000;

if (jumpingPressed and jumpTimer > 0.75 and not bouncing and not falling and arrowJumpingTimer >= arrowJumpTime)
{
	jumpTimer = 0;
	jumping = true;
}

if (jumpTimer > 0 and jumpTimer < 0.5)
{
    jumping = true;
    y = y + ((jumpTimer - 0.25) * 25);
    
    // Keep the shadow stationary relative to the ground while the player jumps
    shadow.x = x - 7; 
    shadow.y = y - 8;
	yJumpOffset += ((jumpTimer - 0.25) * 25);
	shadow.y = shadow.y - yJumpOffset;
}
else
{
    jumping = false;
    shadow.x = x - 7; 
    shadow.y = y - 8;
	yJumpOffset = 0;
}


bounceTimer = bounceTimer - (delta_time / 1000000);

if (bounceTimer > 0) {
    y = y - bounceTimer * 13; // Move the player up based on the bounceTimer
    hasBounced = true; // Set the flag to true since bouncing is occurring
} else if (hasBounced) { // Check if the bounce just finished
    currentFloor = currentFloor + 1;
    hasBounced = false; // Reset the flag to prepare for the next bounce
	bouncing = false;
	arrowJumpingTimer = 2; //make sure this is not carrying over any effects
	
}

bouncingTimer2 = bouncingTimer2 - delta_time / 1000000

if (timeSinceTouchingGround < 0 && bouncing == false)
{
	falling = true;
	if (bouncingTimer2 < -1)
	{
		bouncingTimer2 = 0.5;
	}
}

if (bouncingTimer2 > 0)
{
	y = y + -1 * (bouncingTimer2 - 0.5) * 14;
}

if (bouncingTimer2 < 0 and bouncingTimer2 > -1)
{	
	falling = false;
	timeSinceTouchingGround = 0.5;
	currentFloor = currentFloor - 1;
	bouncingTimer2 = -5;
	
}

if falling {
	alarm[0] = fallEffect;
}

