if (keyboard_check(vk_up)) {
    y -= moveSpeed;
}

if (keyboard_check(vk_down)) {
    y += moveSpeed;
}

if (keyboard_check(vk_left)) {
    x -= moveSpeed;
}

if (keyboard_check(vk_right)) {
    x += moveSpeed;
}

if (not falling)
{
	timeSinceTouchingGround = timeSinceTouchingGround - delta_time / 1000000;
}