/*debugging*/
//quit game
if (keyboard_check(vk_escape)) {
	time += 1/room_speed;
	if (time >= 3) {
		game_end();
	}
}

if (keyboard_check_released(vk_escape) && !keyboard_check(ord("R"))) {
	time = 0;
}

//reset save file
if (keyboard_check(ord("R")) && !keyboard_check(vk_escape)) {
	time += 1/room_speed;
	if (time >= 3) {
		var ini_file;
		ini_file = ini_open("save.ini");
		ini_write_real("SaveData", "LevelNumber", 0);
		ini_close();
		game_restart();
	}
}

if keyboard_check_released(ord("R")) {
	time = 0;
}

//log player position
if (keyboard_check_pressed(vk_enter)) {
	show_debug_message(objPlayer.x);
	show_debug_message(objPlayer.y);
}