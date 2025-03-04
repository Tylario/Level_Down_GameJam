// Step Event for objParticleEffect
// Continue to handle the alpha and destruction from earlier setup
if (image_index < 30) {
    image_alpha = max(0.7 - (image_index * (1 / 15)), 0);  // Continue fading the alpha as set up previously
}

if (image_index >= 29) {
    instance_destroy();  // Destroy the particle after th
}

y = startingY - image_index * 3
