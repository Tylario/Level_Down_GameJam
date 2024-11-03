//restart game
var ini_file;
ini_file = ini_open("save.ini");
ini_write_real("SaveData", "LevelNumber", 0);
game_restart();
ini_close();