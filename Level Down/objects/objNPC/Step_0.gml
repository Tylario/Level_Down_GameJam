//check if a textbox already exists
if (instance_exists(objTextbox)) {
	textboxCreated = true;
}

else {
	textboxCreated = false;
}

//check if player is close enough to start dialogue
if place_meeting(x, y, objPlayer) && keyboard_check_pressed(ord("Z")) && textboxCreated == false {
	io_clear();
	instance_create_layer(0, 0, "Textbox", objTextbox);
}

//destroy dialogue object is player walks away
if (!place_meeting(x, y, objPlayer) && textboxCreated == true) {
	instance_destroy(objTextbox);
	textboxCreated = false;
}