// Set initial values for player properties
depth = -10000;
timeSinceTouchingGround = 0.25;
iceTime = 0;
arrowDirection = "";
arrowJumpingTimer = 10;
jumpTimer = 0.5;
bounceTimer = 0;
hasBounced = false;
bouncing = false;
bouncingMultiplier = 1;
fallingTimer = -5;
midBounceFloorUpdated = false;
midFallFloorUpdated = false;
lastDirection = "none"; // Initialize last direction
shadow = instance_create_layer(x, y, "Instances", objShadow); // Create shadow object
shadow.depth = -9999;
yJumpOffset = 0;
timeSinceTouchingJump = 0;
jumpWhileTouchingJump = false;
levelWithWalls = false;

// Fixed timestep for physics calculations
fixed_time_step = 1 / 60; // 60 updates per second
accumulator = 0; // Accumulator for delta time

// Define the updatePhysics function to handle all physics and game logic
function updatePhysics() {
	   arrowMultiplier = 1;

	var movingLeft = keyboard_check(vk_left) || keyboard_check(ord("A"));
	var movingRight = keyboard_check(vk_right) || keyboard_check(ord("D"));
	var movingUp = keyboard_check(vk_up) || keyboard_check(ord("W"));
	var movingDown = keyboard_check(vk_down) || keyboard_check(ord("S"));
	var jumpingPressed = keyboard_check(vk_space);

	// horizontal movement 
	if (movingLeft xor movingRight) { 
	    if (movingLeft) {
	        xMomentum = xMomentum - acceleration * fixed_time_step;
	        if (xMomentum < -maxSpeed) {
	            xMomentum = -maxSpeed;
	        }
	    } else if (movingRight) {
	        xMomentum = xMomentum + acceleration * fixed_time_step;
	        if (xMomentum > maxSpeed) {
	            xMomentum = maxSpeed;
	        }
	    }
	} else {
	    // decelerate when neither or both left and right keys are pressed
	    if (xMomentum > 0) {
	        xMomentum = xMomentum - acceleration * fixed_time_step;
	        if (xMomentum < 0) {
	            xMomentum = 0;
	        }
	    } else if (xMomentum < 0) {
	        xMomentum = xMomentum + acceleration * fixed_time_step;
	        if (xMomentum > 0) {
	            xMomentum = 0;
	        }
	    }
	}

	// vertical movement
	if (movingUp xor movingDown) { 
	    if (movingUp) {
	        yMomentum = yMomentum - acceleration * fixed_time_step;
	        if (yMomentum < -maxSpeed) {
	            yMomentum = -maxSpeed;
	        }
	    } else if (movingDown) {
	        yMomentum = yMomentum + acceleration * fixed_time_step;
	        if (yMomentum > maxSpeed) {
	            yMomentum = maxSpeed;
	        }
	    }
	} else {
	    // decelerate when neither or both up and down keys are pressed
	    if (yMomentum > 0) {
	        yMomentum = yMomentum - acceleration * fixed_time_step;
	        if (yMomentum < 0) {
	            yMomentum = 0;
	        }
	    } else if (yMomentum < 0) {
	        yMomentum = yMomentum + acceleration * fixed_time_step;
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

	// Reset timer if not jumping or falling
	if (!jumping && !falling && !bouncing) {
	    timeSinceTouchingGround = timeSinceTouchingGround - (fixed_time_step);
	}

	// ice tile
	iceTime = iceTime - (fixed_time_step);

	if (iceTime > 0) {
	    acceleration = 4;
		maxSpeed = 2.6;
		if (jumping)
		{
			acceleration = 2;
		}
	} else {
	    acceleration = 32;
		maxSpeed = 2.2;
		if (jumping)
		{
			acceleration = 4
		}
	}

	// Arrow tiles
	arrowJumpingTimer += fixed_time_step;
	if (arrowJumpingTimer >= 0 && arrowJumpingTimer <= arrowJumpTime) {
	    var someValue = 6; // Define the scale of the jump effect
	    var jumpEffect = someValue * (((-2 * arrowJumpingTimer) / arrowJumpTime) + 1); // Calculate the jump effect
	    var moveAmount = 1.5 / arrowJumpTime;
    
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
	} else {
	    arrowMultiplier = 1;
	}

	if (bouncing) {
	    bouncingMultiplier = 0.3;
	} else {
	    bouncingMultiplier = 1;
	}

	if (levelWithWalls)
	{

		// Calculate potential new positions
		var newXOffset = clamp(xMomentum, -maxSpeed, maxSpeed) * arrowMultiplier * bouncingMultiplier
		var newYOffset = clamp(yMomentum, -maxSpeed, maxSpeed) * arrowMultiplier * bouncingMultiplier
		var newX = x + newXOffset;
		var newY = y + newYOffset;
		var shadow_instance = instance_find(objShadow, 0);
		var shadowX = shadow_instance.x + (shadow_instance.sprite_width / 2);
		var shadowY = shadow_instance.y + (shadow_instance.sprite_height / 2);
		var newShadowX = shadowX + newXOffset;
		var newShadowY = shadowY +newYOffset;

		show_debug_message(currentFloor)

		// Check for collisions at the new positions
		if (!place_meeting(newShadowX, newShadowY, objHexagonWall)) {
		    // No collision at the new position, so move to newX and newY
		    x = newX;
		    y = newY;
		} else {
		    // Check for collision in the y direction only
		    if (!place_meeting(shadowX, newShadowY, objHexagonWall)) {
		        // No collision at the new y position, so move to newY
		        y = newY;
		    }
		    // Check for collision in the x direction only
		    if (!place_meeting(newShadowX, shadowY, objHexagonWall)) {
		        // No collision at the new x position, so move to newX
		        x = newX;
		    }
		}
	}
	else
	{
		var newXOffset = clamp(xMomentum, -maxSpeed, maxSpeed) * arrowMultiplier * bouncingMultiplier
		var newYOffset = clamp(yMomentum, -maxSpeed, maxSpeed) * arrowMultiplier * bouncingMultiplier
		var newX = x + newXOffset;
		var newY = y + newYOffset;
		x = newX;
		y = newY;
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

	// jumping
	if (not jumpWhileTouchingJump)
	{
		jumpTimer = jumpTimer + fixed_time_step;
	}
	else
	{
		jumpTimer = jumpTimer + fixed_time_step * 0.5;
	}

	if (jumpingPressed && jumpTimer > 0.75 && !bouncing && !falling && arrowJumpingTimer >= arrowJumpTime) {
	    jumpTimer = 0;
	    jumping = true;
		
	}

	if (jumpTimer > 0 && jumpTimer < 0.5) {
	    jumping = true;
		if (timeSinceTouchingJump > 0)
		{
			jumpWhileTouchingJump = true;
		}
	    y = y + ((jumpTimer - 0.25) * 25);
    
	    // Keep the shadow stationary relative to the ground while the player jumps
	    shadow.x = x - 7; 
	    shadow.y = y - 8;
	    yJumpOffset += ((jumpTimer - 0.25) * 25);
	    shadow.y = shadow.y - yJumpOffset;
	} else {
	    jumping = false;
		jumpWhileTouchingJump = false;
	    shadow.x = x - 7; 
	    shadow.y = y - 8;
	    yJumpOffset = 0;
	}

	bounceTimer = bounceTimer - (fixed_time_step);

	if (bounceTimer > 0) {
	    y = y - bounceTimer * 13.7; // Move the player up based on the bounceTimer
	    hasBounced = true; // Set the flag to true since bouncing is occurring
    
	    // Update floor halfway through the bounce
	    if (bounceTimer < 0.25 && !midBounceFloorUpdated) { // Adjust the threshold as needed
	        currentFloor = currentFloor + 1;
	        midBounceFloorUpdated = true; // Set flag to true to prevent multiple increments
	    }
	} else if (hasBounced) { // Check if the bounce just finished
	    hasBounced = false; // Reset the flag to prepare for the next bounce
	    bouncing = false;
	    arrowJumpingTimer = 2; // Make sure this is not carrying over any effects
	    midBounceFloorUpdated = false; // Reset flag for the next bounce
	}

	fallingTimer = fallingTimer - (fixed_time_step);
	if (timeSinceTouchingGround < 0 && !bouncing) {
	   falling = true;
	    if (fallingTimer < -1) {
	        fallingTimer = 0.5;
	    }
	}
	
	if (fallingTimer > 0) {
	    y = y + -1 * (fallingTimer - 0.5) * 14;

	    // Update floor halfway through the fall
	    if (fallingTimer < 0.25 && !midFallFloorUpdated) { // Adjust the threshold as needed
	        currentFloor = currentFloor - 1;
	        midFallFloorUpdated = true; // Set flag to true to prevent multiple decrements
	    }
	}

	if (fallingTimer < 0 && fallingTimer > -1) {
	    falling = false;
	    timeSinceTouchingGround = 0.5;
	    fallingTimer = -5;
	    midFallFloorUpdated = false; // Reset flag for the next fall
	}
	
	//jump tile logic
	timeSinceTouchingJump = timeSinceTouchingJump - (fixed_time_step);
}

