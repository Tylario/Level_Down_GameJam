//game restart (when player walks into rocket door)

//this loop will always be running because the player will constantly be colliding with the obj once frozen
if (place_meeting(x, y, objPlayer)) {
	gameEnded = true;
	
	//stops player movement and turn all sprites invisible
	objPlayer.playerMoving = false;
	objPlayer.sprite_index = -1;
	objShadow.sprite_index = -1;
}

if (gameEnded == true && playerCollided == false) {
	//ensures this loop will not repeat so alarms can trigger
	playerCollided = true;

	//pause and have rocket door shut
	alarm[0] = 90
	
	gameEnded = false;
}