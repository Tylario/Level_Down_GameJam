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
bouncingTimer2 = -5;

//create shadow object
shadow = instance_create_layer(x, y, "Instances", objShadow);
shadow.depth = -9999;
yJumpOffset = 0;