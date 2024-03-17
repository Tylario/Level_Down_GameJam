/* Display the win message
show_message("Congratulations! You've won!\n\n- From: objHexagonWin.collider(objPlayer)");
other.timeSinceTouchingGround = 0.1;
// End the game
game_end(); */

layer_sprite_create("logo", room_width/2, objPlayer.y +100, sprYouWin);
alarm[0] = 100;