// Initialize background and game state
background();
depth = -10000;

// Movement timers and states
timeSinceTouchingSpeedTile = 0;
timeSinceTouchingGround = 0.25;
timeSinceTouchingLowGravity = -1;
iceTime = 0;
playerMoving = true;

// Jump and bounce related variables 
jumpTimer = 0.5;
bounceTimer = 0;
hasBounced = false;
bouncing = false;
bouncingMultiplier = 1;
yJumpOffset = 0;
jumpWhileTouchingJump = false;

// Arrow tile variables
arrowDirection = "";
arrowJumpingTimer = 10;

// Fall related variables
fallingTimer = -5;
midBounceFloorUpdated = false;
midFallFloorUpdated = false;

// Direction tracking
lastDirection = "none";

// Create player shadow
shadow = instance_create_layer(x, y, "Instances", objShadow);
shadow.depth = -9999;

// Game state
gameEnd = false;
sound_is_playing = false;

// Load or set starting floor
var ini_file = ini_open("save.ini");
currentFloor = ini_read_real("SaveData", "LevelNumber", 0);
//currentFloor = 28 // Uncomment to start at specific floor
ini_close();

// Position player based on floor number
if (currentFloor > 0) {
    y = 14630 - 100 * currentFloor;
    // Alternate x position based on odd/even floor
    if (currentFloor % 2 == 1) {
        x = 900 - (48 * 5);
    } else {
        x = 900 + (48 * 5);
    }
}

// Physics timestep variables
fixed_time_step = 1/60;
accumulator = 0;

// Movement functions
function handleMovementInput() {
    var movingLeft = keyboard_check(vk_left) || keyboard_check(ord("A"));
    var movingRight = keyboard_check(vk_right) || keyboard_check(ord("D")); 
    var movingUp = keyboard_check(vk_up) || keyboard_check(ord("W"));
    var movingDown = keyboard_check(vk_down) || keyboard_check(ord("S"));
    
    // Handle horizontal movement
    if (movingLeft xor movingRight) {
        if (movingLeft) {
            xMomentum = max(-maxSpeed, xMomentum - acceleration * fixed_time_step);
        } else {
            xMomentum = min(maxSpeed, xMomentum + acceleration * fixed_time_step);
        }
    } else {
        // Decelerate when no horizontal movement
        if (xMomentum > 0) {
            xMomentum = max(0, xMomentum - acceleration * fixed_time_step);
        } else if (xMomentum < 0) {
            xMomentum = min(0, xMomentum + acceleration * fixed_time_step);
        }
    }

    // Handle vertical movement
    if (movingUp xor movingDown) {
        if (movingUp) {
            yMomentum = max(-maxSpeed, yMomentum - acceleration * fixed_time_step);
        } else {
            yMomentum = min(maxSpeed, yMomentum + acceleration * fixed_time_step);
        }
    } else {
        // Decelerate when no vertical movement
        if (yMomentum > 0) {
            yMomentum = max(0, yMomentum - acceleration * fixed_time_step);
        } else if (yMomentum < 0) {
            yMomentum = min(0, yMomentum + acceleration * fixed_time_step);
        }
    }

    // Handle diagonal movement
    handleDiagonalMovement(movingUp, movingDown, movingLeft, movingRight);
}

function handleDiagonalMovement(movingUp, movingDown, movingLeft, movingRight) {
    diagonalSpeedMultiplier = 1.1;
    if ((movingUp || movingDown) && (movingLeft || movingRight)) {
        var combinedSpeed = sqrt(xMomentum * xMomentum + yMomentum * yMomentum);
        var diagonalSpeedCap = maxSpeed * 0.71 * diagonalSpeedMultiplier;

        if (combinedSpeed > diagonalSpeedCap) {
            var scaleRatio = diagonalSpeedCap / combinedSpeed;
            xMomentum *= scaleRatio;
            yMomentum *= scaleRatio;
        }
    }
}

function updateMovementModifiers() {
    // Update ground contact timers
    if (!jumping && !falling && !bouncing) {
        timeSinceTouchingGround -= fixed_time_step;
        timeSinceTouchingLowGravity -= fixed_time_step;
    }

    // Handle movement modifiers (ice, low gravity)
    iceTime -= fixed_time_step;
    
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

function handleArrowTileEffects() {
    arrowJumpingTimer += fixed_time_step;
    if (arrowJumpingTimer >= 0 && arrowJumpingTimer <= arrowJumpTime) {
        var jumpEffect = 1.3 * (((-2 * arrowJumpingTimer) / arrowJumpTime) + 1);
        var moveAmount = 0.46 / arrowJumpTime;
        
        applyArrowMovement(moveAmount);
        y -= jumpEffect;
        arrowMultiplier = 0.3;
    } else {
        arrowMultiplier = 1;
    }
}

function applyArrowMovement(moveAmount) {
    switch(arrowDirection) {
        case "Up":
            y -= moveAmount;
            break;
        case "Up Right":
            y -= moveAmount * 0.46947;
            x += moveAmount * 0.88295;
            break;
        case "Down Right":
            y += moveAmount * 0.46947;
            x += moveAmount * 0.88295;
            break;
        case "Down":
            y += moveAmount;
            break;
        case "Down Left":
            y += moveAmount * 0.46947;
            x -= moveAmount * 0.88295;
            break;
        case "Up Left":
            y -= moveAmount * 0.46947;
            x -= moveAmount * 0.88295;
            break;
    }
}

function handleCollisions() {
    var newXOffset = clamp(xMomentum, -maxSpeed, maxSpeed) * arrowMultiplier * bouncingMultiplier;
    var newYOffset = clamp(yMomentum, -maxSpeed, maxSpeed) * arrowMultiplier * bouncingMultiplier;

    var shadow_instance = instance_find(objShadow, 0);
    var positions = calculateNewPositions(newXOffset, newYOffset, shadow_instance);
    
    processCollisionsAndMove(positions);
}

function calculateNewPositions(newXOffset, newYOffset, shadow_instance) {
    if (!falling) {
        return {
            newX: x + newXOffset,
            newY: y + newYOffset,
            shadowX: shadow_instance.x + (shadow_instance.sprite_width / 2) - 5,
            shadowY: shadow_instance.y + (shadow_instance.sprite_height / 2) - 2,
            newShadowX: shadow_instance.x + (shadow_instance.sprite_width / 2) - 5 + newXOffset,
            newShadowY: shadow_instance.y + (shadow_instance.sprite_height / 2) - 2 + newYOffset
        };
    } else {
        return {
            newX: x,
            newY: y,
            shadowX: shadow_instance.x,
            shadowY: shadow_instance.y,
            newShadowX: shadow_instance.x,
            newShadowY: shadow_instance.y
        };
    }
}

function check_collision(xPos, yPos) {
    var collisionRadius = 3;
    var objTypes = [objHexagonWall, objHexagonInvisibleWall, objNPC, objRocketShipInvisibleBorder];
    
    var positions = [
        [xPos, yPos - collisionRadius],
        [xPos, yPos + collisionRadius],
        [xPos - collisionRadius, yPos],
        [xPos + collisionRadius, yPos]
    ];

    for (var i = 0; i < array_length_1d(objTypes); i++) {
        for (var j = 0; j < array_length_1d(positions); j++) {
            var inst = instance_place(positions[j][0], positions[j][1], objTypes[i]);
            if (inst != noone) {
                if (!variable_instance_exists(inst, "floorNumber") || inst.floorNumber == currentFloor) {
                    return inst;
                }
            }
        }
    }
    return noone;
}

function processCollisionsAndMove(positions) {
    var initialCollision = check_collision(positions.shadowX, positions.shadowY);
    if (initialCollision != noone) {
        x = positions.newX;
        y = positions.newY;
    } else {
        var newCollision = check_collision(positions.newShadowX, positions.newShadowY);
        if (newCollision == noone) {
            x = positions.newX;
            y = positions.newY;
        } else {
            if (check_collision(positions.shadowX, positions.newShadowY) == noone) {
                y = positions.newY;
            }
            if (check_collision(positions.newShadowX, positions.shadowY) == noone) {
                x = positions.newX;
            }
        }
    }
}

function updateDirection() {
    lastDirection = "none";
    if (xMomentum < 0) lastDirection = "left";
    else if (xMomentum > 0) lastDirection = "right";

    if (yMomentum < 0) {
        if (lastDirection == "left") lastDirection = "upLeft";
        else if (lastDirection == "right") lastDirection = "upRight";
        else lastDirection = "up";
    } else if (yMomentum > 0) {
        if (lastDirection == "left") lastDirection = "downLeft";
        else if (lastDirection == "right") lastDirection = "downRight";
        else lastDirection = "down";
    }
}

function updateSprite() {
    var isMoving = xMomentum != 0 || yMomentum != 0;
    
    if (isMoving) {
        image_speed = 1;
        switch(lastDirection) {
            case "left": sprite_index = sprWalkLeft; break;
            case "right": sprite_index = sprWalkRight; break;
            case "up": sprite_index = sprWalkUp; break;
            case "down": sprite_index = sprWalkDown; break;
            case "upLeft": sprite_index = sprWalkUpLeft; break;
            case "upRight": sprite_index = sprWalkUpRight; break;
            case "downLeft": sprite_index = sprWalkDownLeft; break;
            case "downRight": sprite_index = sprWalkDownRight; break;
        }
    } else {
        image_speed = 0;
        image_index = 0;
        switch(lastDirection) {
            case "left": sprite_index = sprLeftIdle; break;
            case "right": sprite_index = sprRightIdle; break;
            case "up": sprite_index = sprUpIdle; break;
            case "down": sprite_index = sprDownIdle; break;
            case "upLeft": sprite_index = sprUpLeftIdle; break;
            case "upRight": sprite_index = sprUpRightIdle; break;
            case "downLeft": sprite_index = sprDownLeftIdle; break;
            case "downRight": sprite_index = sprDownRightIdle; break;
        }
    }

    image_speed = isMoving ? 0.5 : 0;
}

function handleJumping() {
    var jumpingPressed = keyboard_check(vk_space);
    var jumpSpeedMultiplier = 1;
    
    if (jumpWhileTouchingJump) jumpSpeedMultiplier = 0.5;
    else if (timeSinceTouchingLowGravity > 0) jumpSpeedMultiplier = 0.6;
    
    jumpTimer += fixed_time_step * jumpSpeedMultiplier;
    
    if (jumpTimer > 0 && jumpTimer < 0.5) {
        processActiveJump();
    } else {
        processJumpEnd();
    }

    // Handle jump input
    if (jumpingPressed && jumpTimer > 0.57 && !bouncing && !falling && 
        arrowJumpingTimer >= arrowJumpTime && timeSinceTouchingGround > 0.01) {
        initiateJump();
    }
}

function processActiveJump() {
    jumping = true;
    y += (jumpTimer - 0.25) * 25;
    
    shadow.x = x - 1;
    shadow.y = y - 2;
    yJumpOffset += (jumpTimer - 0.25) * 25;
    shadow.y -= yJumpOffset;
}

function processJumpEnd() {
    if (jumpTimer == 0) {
        jumping = false;
        jumpWhileTouchingJump = false;
        shadow.x = x - 1;
        shadow.y = y - 2;
        yJumpOffset = 0;
    } else {
        jumping = false;
        jumpWhileTouchingJump = false;
        shadow.x = x - 1;
        shadow.y = y - 2;
        yJumpOffset = 0;
        if (endJump) {
            endJump = false;
            if (!isOverCurrentFloorHexagon()) {
                jumpFallTimer = 0;
                falling = true;
                endJump = true;
                fallingTimer = 0.202;
            }
        }
    }
}

function initiateJump() {
    jumpTimer = 0;
    jumping = true;
    timeSinceTouchingGround = 0.01;
    endJump = true;
    endFall = true;
    
    var sound = choose(sndJump1, sndJump2, sndJump3);
    audio_play_sound(sound, 1, false, global.volume);
    audio_sound_pitch(sound, 3);
    
    if (timeSinceTouchingLowGravity > 0) {
        audio_play_sound(sndLowGravityJump, 1, false, global.volume);
        audio_sound_pitch(sndLowGravityJump, 3);
    }
}

function handleBouncing() {
    bounceTimer -= fixed_time_step;
    
    if (bounceTimer > 0) {
        y -= bounceTimer * 13.7;
        hasBounced = true;
        
        if (bounceTimer < 0.25 && !midBounceFloorUpdated) {
            currentFloor += 1;
            midBounceFloorUpdated = true;
        }
    } else if (hasBounced) {
        hasBounced = false;
        bouncing = false;
        arrowJumpingTimer = 2;
        midBounceFloorUpdated = false;
    }
}

function handleFalling() {
    jumpFallTimer -= fixed_time_step;
    fallingTimer -= fixed_time_step;
    
    if (jumpFallTimer > -0.5 && jumpFallTimer <= 0) {
        y += (jumpFallTimer + 0.5) * 5;
    }

    if (timeSinceTouchingGround < 0 && !bouncing) {
        initiateFall();
    }
    
    if (fallingTimer > 0) {
        processFall();
    }

    if (fallingTimer < 0 && fallingTimer > -1) {
        endFalling();
    }
}

function initiateFall() {
    falling = true;
    endFall = true;
    if (fallingTimer < -1) {
        fallingTimer = 0.5;
        depth = ((-objShadow.y + 16) * 2) + 34000 - (currentFloor * 50);
        objShadow.depth = depth + 1;
    }
}

function processFall() {
    y += -1 * (fallingTimer - 0.5) * 14;

    if (fallingTimer < 0.25 && !midFallFloorUpdated) {
        currentFloor -= 1;
        midFallFloorUpdated = true;
    }
}

function endFalling() {
    falling = false;
    timeSinceTouchingGround = 0.5;
    fallingTimer = -5;
    midFallFloorUpdated = false;
    if (endFall) {
        endFall = false;
        if (!isOverCurrentFloorHexagon()) {
            jumpFallTimer = 0;
            falling = true;
            fallingTimer = 0.202;
            endFall = true;
        }
    }
}

function updateParallax() {
    var layerPlanets = layer_get_id("Planets");
    var layerStars = layer_get_id("Stars"); 
    var layerBackground = layer_get_id("Background");

    // Update planet layer (slowest)
    layer_x(layerPlanets, layer_get_x(layerPlanets) - (shadow.x - shadow.xprevious) * -0.2);
    layer_y(layerPlanets, layer_get_y(layerPlanets) - (shadow.y - shadow.yprevious) * -0.2);

    // Update stars layer (medium)
    layer_x(layerStars, layer_get_x(layerStars) - (shadow.x - shadow.xprevious) * -0.3);
    layer_y(layerStars, layer_get_y(layerStars) - (shadow.y - shadow.yprevious) * -0.3);

    // Update background layer (fastest)
    layer_x(layerBackground, layer_get_x(layerBackground) - (shadow.x - shadow.xprevious) * -0.4);
    layer_y(layerBackground, layer_get_y(layerBackground) - (shadow.y - shadow.yprevious) * -0.4);
}

function updateLowGravitySound() {
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

function isOverCurrentFloorHexagon() {
    var hexagons = ds_list_create();
    var count = instance_place_list(x, y, objParentHexagon, hexagons, false);
    var validHexagon = false;
    
    for (var i = 0; i < count; i++) {
        var hex = hexagons[| i];
        if (hex.floorNumber == currentFloor) {
            validHexagon = true;
            break;
        }
    }
    
    ds_list_destroy(hexagons);
    return validHexagon;
}

// Main physics and game logic update function
function updatePhysics() {
    arrowMultiplier = 0.2;
    
    handleMovementInput();
    updateMovementModifiers();
    handleArrowTileEffects();
    
    bouncingMultiplier = bouncing ? 0.3 : 1;
    
    handleCollisions();
    updateDirection();
    updateSprite();
    handleJumping();
    handleBouncing();
    handleFalling();
    updateParallax();
    updateLowGravitySound();
}