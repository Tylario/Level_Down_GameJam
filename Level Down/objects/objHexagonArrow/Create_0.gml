var randomNumber = irandom_range(0, 5);
arrowDirection = "";

switch(randomNumber) {
    case 0:
        sprite_index = sprHexagonArrowUpDesaturated;
        arrowDirection = "Up";
        break;
    case 1:
        sprite_index = sprHexagonArrowUpRightDesaturated;
        arrowDirection = "Up Right";
        break;
    case 2:
        sprite_index = sprHexagonArrowDownRightDesaturated;
        arrowDirection = "Down Right";
        break;
    case 3:
        sprite_index = sprHexagonArrowDownDesaturated;
        arrowDirection = "Down";
        break;
    case 4:
        sprite_index = sprHexagonArrowDownLeftDesaturated;
        arrowDirection = "Down Left";
        break;
    case 5:
        sprite_index = sprHexagonArrowUpLeftDesaturated;
        arrowDirection = "Up Left";
        break;
}

// Create the secondary hitbox object and store the reference in a variable
hitbox = instance_create_layer(x, y, "Instances", objArrowHitbox);

// Set the arrowDirection of the hitbox to match the parent object's arrowDirection
hitbox.arrowDirection = arrowDirection;

alarm[0] = 1; //Set hitbox floornumber variable = floorNumber

// Store a reference back to the parent object
hitbox.parent_arrow  = id;


/// @desc Changes the sprite to the desaturated version and sets an alarm to revert back
function desaturateSprite() {
    // Check the current sprite_index and change to the desaturated version
    switch(sprite_index) {
        case sprHexagonArrowUpDesaturated:
            sprite_index = sprHexagonArrowUp;
            break;
        case sprHexagonArrowUpRightDesaturated:
            sprite_index = sprHexagonArrowUpRight;
            break;
        case sprHexagonArrowDownRightDesaturated:
            sprite_index = sprHexagonArrowDownRight;
            break;
        case sprHexagonArrowDownDesaturated:
            sprite_index = sprHexagonArrowDown;
            break;
        case sprHexagonArrowDownLeftDesaturated:
            sprite_index = sprHexagonArrowDownLeft;
            break;
        case sprHexagonArrowUpLeftDesaturated:
            sprite_index = sprHexagonArrowUpLeft;
            break;
    }

    // revert the sprite back 
    alarm[1] = 20;
}

