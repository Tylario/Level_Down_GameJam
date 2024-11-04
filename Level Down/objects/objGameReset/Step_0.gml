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
	alarm[0] = 120
	gameEnded = false;
}

//can restart
if (canRestart == true) {
	if (keyboard_check_pressed(ord("Z"))) {
		var ini_file;
		ini_file = ini_open("save.ini");
		ini_write_real("SaveData", "LevelNumber", 0);
		ini_close();
		game_restart();
		canRestart = false;
	}
	
}