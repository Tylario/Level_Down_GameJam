/*debugging*/
//quit game
if (keyboard_check_pressed(vk_escape)) 
{
    game_end();
}

//log player position
if (keyboard_check_pressed(vk_enter)) {
	show_debug_message(objPlayer.x);
	show_debug_message(objPlayer.y);
}