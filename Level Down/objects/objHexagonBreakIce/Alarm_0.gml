var seconds = 1 / room_speed;

// Accelerate downwards
currentSpeed += fallingAcceleration * seconds;
y += currentSpeed;

// Fade out the image gradually
var alphaDecreasePerFrame = 1 / (fallingTime * room_speed);
image_alpha -= alphaDecreasePerFrame;
image_alpha = max(image_alpha, 0);

// Reduce the remaining falling time
fallingTime -= seconds;

// If time is up, destroy the instance; otherwise, reset alarm[0] to continue falling
if (fallingTime <= 0) {
    instance_destroy();
} else {
    alarm[0] = 1; // Continue falling on the next frame
}
