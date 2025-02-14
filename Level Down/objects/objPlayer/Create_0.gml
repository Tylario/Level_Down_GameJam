//call background generating function
background();
timeSinceTouchingSpeedTile = 0;
playerMoving = true;
depth = -10000;
timeSinceTouchingGround = 0.25;
timeSinceTouchingLowGravity = -1;
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
//needToBounce = 0;
jumpWhileTouchingJump = false;
gameEnd = false;
sound_is_playing = false;
isQuickFalling = false;
quickFallSpeed = 4.9; // Speed for quick falling (adjust as needed)
endFall = false;  // Add this initialization

var ini_file;
ini_file = ini_open("save.ini");
currentFloor = ini_read_real("SaveData", "LevelNumber", 0); // Default to 0 if not found
currentFloor = 44 // comment out previous line, and uncomment out this line to customize starting floor
ini_close();

if (currentFloor > 0)
{
	y = y - 100 * currentFloor
	if (currentFloor % 2 == 1)
	{
		x = 900 - (48 * 5) 
	}
	else
	{
		x = 900 + (48 * 5) 
	}
}

// Fixed timestep for physics calculations
fixed_time_step = 1 / 60; // 60 updates per second
accumulator = 0; // Accumulator for delta time

// Define the updatePhysics function to handle all physics and game logic
function updatePhysics() {
    arrowMultiplier = 0.2;
    
    // Consolidate input checks
    var input = {
        left: keyboard_check(vk_left) || keyboard_check(ord("A")),
        right: keyboard_check(vk_right) || keyboard_check(ord("D")),
        up: keyboard_check(vk_up) || keyboard_check(ord("W")),
        down: keyboard_check(vk_down) || keyboard_check(ord("S")),
        jump: keyboard_check(vk_space)
    };

    // Helper function for momentum calculations
    function update_momentum(current_momentum, moving, direction) {
        if (moving) {
            current_momentum += direction * acceleration * fixed_time_step;
            return clamp(current_momentum, -maxSpeed, maxSpeed);
        } else {
            var decel = min(abs(current_momentum), acceleration * fixed_time_step);
            return approach(current_momentum, 0, decel);
        }
    }

    // Update horizontal and vertical momentum
    if (input.left xor input.right) {
        xMomentum = update_momentum(xMomentum, true, input.left ? -1 : 1);
    } else {
        xMomentum = update_momentum(xMomentum, false, 0);
    }

    if (input.up xor input.down) {
        yMomentum = update_momentum(yMomentum, true, input.up ? -1 : 1);
    } else {
        yMomentum = update_momentum(yMomentum, false, 0);
    }

    // Diagonal movement adjustment
    if ((input.up || input.down) && (input.left || input.right)) {
        var combinedSpeed = sqrt(xMomentum * xMomentum + yMomentum * yMomentum);
        var diagonalSpeedCap = maxSpeed * 0.71 * 1.1; // Combined diagonal speed multiplier

        if (combinedSpeed > diagonalSpeedCap) {
            var scaleRatio = diagonalSpeedCap / combinedSpeed;
            xMomentum *= scaleRatio;
            yMomentum *= scaleRatio;
        }
    }

    // Update timers
    if (!jumping && !falling && !bouncing) {
        timeSinceTouchingGround -= fixed_time_step;
        timeSinceTouchingLowGravity -= fixed_time_step;
    }
    
    iceTime -= fixed_time_step;
    bounceTimer -= fixed_time_step;
    jumpFallTimer -= fixed_time_step;
    fallingTimer -= fixed_time_step;

    // Update movement properties based on conditions
    function update_movement_properties() {
        if (iceTime > 0) {
            acceleration = jumping ? 2 : 4;
            maxSpeed = 2.6;
        } else if (timeSinceTouchingLowGravity > 0) {
            acceleration = jumping ? 4 : 16;
            maxSpeed = 2.9;
        } else {
            acceleration = jumping ? 4 : 32;
            maxSpeed = 2.2;
        }
    }
    update_movement_properties();

    // Arrow tiles
    arrowJumpingTimer += fixed_time_step;
    if (arrowJumpingTimer >= 0 && arrowJumpingTimer <= arrowJumpTime) 
    {
        var someValue = 1.3; // Define the scale of the jump effect
        var jumpEffect = someValue * (((-2 * arrowJumpingTimer) / arrowJumpTime) + 1); // Calculate the jump effect
        var moveAmount = 0.46 / arrowJumpTime;
    
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

// Calculate potential new positions
var newXOffset = clamp(xMomentum, -maxSpeed, maxSpeed) * arrowMultiplier * bouncingMultiplier;
var newYOffset = clamp(yMomentum, -maxSpeed, maxSpeed) * arrowMultiplier * bouncingMultiplier;
if (not falling)
{
    var newX = x + newXOffset;
    var newY = y + newYOffset;
    var shadow_instance = instance_find(objShadow, 0);
    var shadowX = shadow_instance.x + (shadow_instance.sprite_width / 2) - 5;
    var shadowY = shadow_instance.y + (shadow_instance.sprite_height / 2) - 2;
    var newShadowX = shadowX + newXOffset;
    var newShadowY = shadowY + newYOffset;
}
else
{
    var newX = x
    var newY = y
    var shadow_instance = instance_find(objShadow, 0);
    var shadowX = shadow_instance.x
    var shadowY = shadow_instance.y
    var newShadowX = shadowX
    var newShadowY = shadowY
}

// Offset and radius for collision checks


    // Function to check collision with all objHexagonWall instances at four positions around a center, including corners
function check_collision(xPos, yPos) {
    // Function to check collision with objHexagonWall, objHexagonInvisibleWall, and objNPC instances
    var collisionRadius = 3; // Distance from the center for collision checks
    var objTypes = [objHexagonWall, objHexagonInvisibleWall, objNPC, objRocketShipInvisibleBorder]; // Includes objNPC
    var inst;

    // Loop through each type of object
    for (var i = 0; i < array_length_1d(objTypes); i++) {
        var objectType = objTypes[i];

        // Check four cardinal directions only
        var positions = [
            [xPos, yPos - collisionRadius], // Up
            [xPos, yPos + collisionRadius], // Down
            [xPos - collisionRadius, yPos], // Left
            [xPos + collisionRadius, yPos]  // Right
        ];

        // Check each position for collisions
        for (var j = 0; j < array_length_1d(positions); j++) {
            inst = instance_place(positions[j][0], positions[j][1], objectType);
            if (inst != noone) {
                // Check if the instance has the variable "floorNumber"
                if (variable_instance_exists(inst, "floorNumber")) {
                    if (inst.floorNumber == currentFloor) {
                        return inst;  // Return the instance if floorNumber matches
                    }
                } else {
                    return inst; // Return the instance if no floorNumber check is needed (like objNPC)
                }
            }
        }
    }

    return noone;  // Return noone if no collisions are found
}




// Check all combinations of previous and new positions for shadow
var initialCollision = check_collision(shadowX, shadowY);
if (initialCollision != noone) { 
        x = newX;
        y = newY;
} else {
    // No initial collision, check the new positions directly
    var newCollision = check_collision(newShadowX, newShadowY);
    if (newCollision == noone) {
        x = newX;
        y = newY;
    } else {
        // Check for collision with new Y only
        var yCollision = check_collision(shadowX, newShadowY);
        if (yCollision == noone) {
            y = newY;
        }

        // Check for collision with new X only
        var xCollision = check_collision(newShadowX, shadowY);
        if (xCollision == noone) {
            x = newX;
        }
    }
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
    if (jumpWhileTouchingJump)
    {
        jumpTimer = jumpTimer + fixed_time_step * 0.5;
    }
    else if (timeSinceTouchingLowGravity > 0)
    {
        jumpTimer = jumpTimer + fixed_time_step * 0.6;
    }
    else
    {
        jumpTimer = jumpTimer + fixed_time_step;
    }
    
    if (jumpTimer > 0 && jumpTimer < 0.5) {
        jumping = true;
        y = y + ((jumpTimer - 0.25) * 25);
    
        // Keep the shadow stationary relative to the ground while the player jumps
        shadow.x = x - 1; 
        shadow.y = y - 2;
        yJumpOffset += ((jumpTimer - 0.25) * 25);
        shadow.y = shadow.y - yJumpOffset;
    } else {
        if (jumpTimer == 0)
        {
            jumping = false;
            jumpWhileTouchingJump = false;
            shadow.x = x - 1; 
            shadow.y = y - 2;
            yJumpOffset = 0;
        }
        else
        {
            jumping = false;
            jumpWhileTouchingJump = false;
            shadow.x = x - 1; 
            shadow.y = y - 2;
            yJumpOffset = 0;
            if (endJump)
            {
                endJump = false
                if (!place_meeting(x, y, objParentHexagon)) 
                {
                    jumpFallTimer = 0
                    falling = true
                    endJump = true
                    fallingTimer = 0
                    isQuickFalling = true;
                }
            }
        }
    }

    bounceTimer = bounceTimer - (fixed_time_step / 2);
    jumpFallTimer = jumpFallTimer - (fixed_time_step);
    
    if (jumpFallTimer > -0.5 and jumpFallTimer <= 0)
    {
        y = y + (jumpFallTimer + 0.5) * 5;
    }

    if (bounceTimer > 0) {
        y = y - bounceTimer * 20; // Move the player up based on the bounceTimer
        hasBounced = true; // Set the flag to true since bouncing is occurring
    
        // Update floor halfway through the bounce
        if (bounceTimer < 0.25 && !midBounceFloorUpdated) { 
            currentFloor = currentFloor + 1;
            midBounceFloorUpdated = true; // Set flag to true to prevent multiple increments
        }
    } else if (hasBounced) {
        hasBounced = false;
        bouncing = false;
        arrowJumpingTimer = 2;
        midBounceFloorUpdated = false;
        if (!place_meeting(x, y, objParentHexagon)) {
            falling = true;
            fallingTimer = 0;
            isQuickFalling = true;
        }
    }

    fallingTimer = fallingTimer - (fixed_time_step);
    if (timeSinceTouchingGround < 0 && !bouncing) {
       falling = true;
       endFall = true;
        if (fallingTimer < -1) {
            fallingTimer = 1.0;
            depth = ((-objShadow.y + 16) * 2) + 34000 - (currentFloor * 50);
            objShadow.depth = ((-objShadow.y + 16) * 2) + 34000 - (currentFloor * 50) + 1;
        }
    }
    
    if (fallingTimer > 0) {
        if (isQuickFalling && currentFloor % 5 != 0) {  // Only allow quick falling if not on a multiple of 5
            fallingTimer -= fixed_time_step * 1.2;
            // Use a constant fall speed instead of accumulating
            y = y + quickFallSpeed;  // Use the defined quickFallSpeed constant
            show_debug_message("Quick falling: y=" + string(y) + " timer=" + string(fallingTimer));
        } else {
            // Normal falling behavior
            y = y + -1 * (fallingTimer - 1.0) * 7;
            show_debug_message("Normal falling: y=" + string(y) + " timer=" + string(fallingTimer));
        }

        if (fallingTimer < 0.5 && !midFallFloorUpdated) {
            currentFloor = currentFloor - 1;
            midFallFloorUpdated = true;
        }
    }
	else
	{
		if (isQuickFalling)
		{
			show_debug_message("Quick Falling: True")
		}
		else
		{
			show_debug_message("Quick Falling: False")
		}
	}

    if (fallingTimer < 0 && fallingTimer > -1) {
        falling = false;
        fallingTimer = -5;
        midFallFloorUpdated = false;
        if (endFall) {
            endFall = false;
            if (!place_meeting(x, y, objParentHexagon)) {
                jumpFallTimer = 0;
                falling = true;
                fallingTimer = 0;
                endFall = true;
            }
        }
    }

	if (bounceTimer < -2.4 && fallingTimer < -2 && timeSinceTouchingGround > 0 && !jumping && !bouncing && !falling)
	{
		isQuickFalling = false;
	}

    

    
    if (input.jump && jumpTimer > 0.57 && !bouncing && !falling && arrowJumpingTimer >= arrowJumpTime && timeSinceTouchingGround > 0.01) 
	{
        jumpTimer = 0;
        jumping = true;
		timeSinceSpawn = -1;
        isQuickFalling = true;  // Set when starting a jump
        timeSinceTouchingGround = 0;
        endJump = true;
        endFall = true;
        var sound = choose(sndJump1, sndJump2, sndJump3);
        audio_play_sound(sound, 1, false, global.volume);
        audio_sound_pitch(sound, 3);
        if (timeSinceTouchingLowGravity > 0)
        {
            audio_play_sound(sndLowGravityJump, 1, false, global.volume);
            audio_sound_pitch(sndLowGravityJump, 3);
        }

    }
    
// Retrieve layer IDs
var layerPlanets = layer_get_id("Planets");
var layerStars = layer_get_id("Stars");
var layerBackground = layer_get_id("Background");

// Parallax scrolling factors for each layer
var speedFactorX1 = -0.2; // Farther background (moves slower horizontally)
var speedFactorY1 = -0.2; // Farther background (moves slower vertically)

var speedFactorX2 = -0.3; // Middle background (moves horizontally)
var speedFactorY2 = -0.3; // Middle background (moves vertically)

var speedFactorX3 = -0.4; // Closest background (moves faster horizontally)
var speedFactorY3 = -0.4; // Closest background (moves faster vertically)

// Adjust the background positions based on shadow movement
layer_x(layerPlanets, layer_get_x(layerPlanets) - (shadow.x - shadow.xprevious) * speedFactorX1);
layer_y(layerPlanets, layer_get_y(layerPlanets) - (shadow.y - shadow.yprevious) * speedFactorY1);

layer_x(layerStars, layer_get_x(layerStars) - (shadow.x - shadow.xprevious) * speedFactorX2);
layer_y(layerStars, layer_get_y(layerStars) - (shadow.y - shadow.yprevious) * speedFactorY2);

layer_x(layerBackground, layer_get_x(layerBackground) - (shadow.x - shadow.xprevious) * speedFactorX3);
layer_y(layerBackground, layer_get_y(layerBackground) - (shadow.y - shadow.yprevious) * speedFactorY3);


    // Update sound based on timeSinceTouchingLowGravity
    function update_sounds() {
        if (timeSinceTouchingLowGravity > 0 && !sound_is_playing) {
            var sound_id = audio_play_sound(sndElectricHum, 1, true);
            audio_sound_pitch(sound_id, 2);
            audio_sound_gain(sound_id, global.volume, 0);
            sound_is_playing = true;
        } else if (timeSinceTouchingLowGravity <= 0 && sound_is_playing) {
            audio_stop_sound(sndElectricHum);
            sound_is_playing = false;
        }
    }
    update_sounds();
}

// Helper function for smooth value approaching
function approach(current, target, amount) {
    if (current < target) {
        return min(current + amount, target);
    } else {
        return max(current - amount, target);
    }
}