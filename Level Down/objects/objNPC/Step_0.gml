// Check if a textbox already exists
if (instance_exists(objTextbox)) {
    textboxCreated = true;
} else {
    textboxCreated = false;
}

// Check if player is close enough to start dialogue (within 60 pixels)
if (distance_to_object(objPlayer) <= 60 && keyboard_check_pressed(ord("Z")) && textboxCreated == false) {
    io_clear();
    instance_create_layer(0, 0, "Textbox", objTextbox);
}

// Destroy dialogue object if player walks away
if (distance_to_object(objPlayer) > 60 && textboxCreated == true) {
    instance_destroy(objTextbox);
    textboxCreated = false;
}

// Update dialogue indicator sprite based on textbox existence
if (textboxCreated == false) {
    objDialogueIndicator.sprite_index = sprDialogueIndicator;
} else {
    objDialogueIndicator.sprite_index = -1;
}


if (y < objPlayer.y) {
    depth = objPlayer.depth + 1;  // Place slightly in front of player
} else {
    depth = objPlayer.depth - 1; // Place slightly behind player
}
