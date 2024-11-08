// Calculate the time per frame in seconds
var seconds = 1 / room_speed;

if (currentSpeed == 0)
{
    var sound_choice = choose(sndPop1, sndPop2, sndPop3, sndPop4, sndPop5, sndPop6, sndPop7, sndPop8, sndPop10);
	var randomPitch = random_range(0.3, 0.5);
	audio_play_sound(sndPop1, 0, false, global.volume * 0.25);
	audio_sound_pitch(sndPop1, randomPitch);

}

// Accelerate downwards
currentSpeed += fallingAcceleration * seconds;
y += currentSpeed;

// Fade out the image
var alphaDecreasePerFrame = 1 / (fallingTime * room_speed); // Total decrease over alarm time
image_alpha -= alphaDecreasePerFrame;
image_alpha = max(image_alpha, 0);

// Reduce the remaining falling time
fallingTime -= seconds;

// If time is up, destroy the instance; otherwise, reset alarm[0] to continue falling
if (fallingTime <= 0) {
    instance_destroy();
} else {
    alarm[0] = 1; // Re-trigger the alarm to continue processing in the next frame
}
