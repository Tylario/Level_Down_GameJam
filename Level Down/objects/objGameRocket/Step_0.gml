//keep rocket invivible unless player is on floor 100
if (objPlayer.currentFloor == 100) {
	visible = true;
	objRocketShadow.visible = true;
}

//game restart (when player walks into rocket door)
if (gameEnded == true and hasTriggered == false) {
	//pause and have rocket door shut
	alarm[0] = 120
	gameEnded = false;
	
	
	hasTriggered = true;
}

if (flying) {
	alarm[4] = 1;
	objRocketShadow.image_speed = 1;
}

if (showWinSprite)
{
	adder = adder + 2
	
}

objPlayer.y = objPlayer.y + adder;

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

if (y + 65 < objShadow.y) {
    depth = objPlayer.depth + 1;  // Place slightly in front of player
} else {
    depth = objPlayer.depth - 1; // Place slightly behind player
}
