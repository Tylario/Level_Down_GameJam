var randomNumber = irandom_range(0, 5);
arrowDirection = "";

switch(randomNumber) {
    case 0:
        sprite_index = sprHexagonArrowUp;
        arrowDirection = "Up";
        break;
    case 1:
        sprite_index = sprHexagonArrowUpRight;
        arrowDirection = "Up Right";
        break;
    case 2:
        sprite_index = sprHexagonArrowDownRight;
        arrowDirection = "Down Right";
        break;
    case 3:
        sprite_index = sprHexagonArrowDown;
        arrowDirection = "Down";
        break;
    case 4:
        sprite_index = sprHexagonArrowDownLeft;
        arrowDirection = "Down Left";
        break;
    case 5:
        sprite_index = sprHexagonArrowUpLeft;
        arrowDirection = "Up Left";
        break;
}


// Create the secondary hitbox object and store the reference in a variable
hitbox = instance_create_layer(x, y, "Instances", objArrowHitbox);

// Set the arrowDirection of the hitbox to match the parent object's arrowDirection
hitbox.arrowDirection = arrowDirection;
hitbox.floorNumber = floorNumber;

// Store a reference back to the parent object
hitbox.parent_object = id;