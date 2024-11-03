//game restart
if (place_meeting(x, y, objPlayer)) {
	alarm[0] = 60
	//layer_sprite_create("Cutscene",objPlayer.x, objPlayer.y, sprPlayerSpin);
	
	/*var ini_file;
	ini_file = ini_open("save.ini");
	ini_write_real("SaveData", "LevelNumber", 0);
	game_restart();
	ini_close();*/
}