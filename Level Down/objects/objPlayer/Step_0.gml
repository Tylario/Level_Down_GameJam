// Define your movement speed
var moveSpeed = 4;

// Moving Up
if (keyboard_check(vk_up)) {
    y -= moveSpeed;
}

// Moving Down
if (keyboard_check(vk_down)) {
    y += moveSpeed;
}

// Moving Left
if (keyboard_check(vk_left)) {
    x -= moveSpeed;
}

// Moving Right
if (keyboard_check(vk_right)) {
    x += moveSpeed;
}
