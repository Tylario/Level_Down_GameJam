interactKey = keyboard_check_pressed(ord("z"));

textboxX = camera_get_view_x(view_camera[0]);
textboxY = camera_get_view_y(view_camera[0] + 240); //added num for y offset (?)

//setup
if setup == false {
	setup = true;
	draw_set_font(fntHabbo);
	draw_set_valign(fa_top);
	draw_set_halign(fa_left);
	
	//loop through pages
	pageNumber = array_length(text);
	for(var i = 0; i < pageNumber; i++) {
		//store number of characters on each page in array textLength
		textLength[i] = string_length(text[i]);
		
		//textbox distance from left of the screen (centering)
		textXOffset[p] = 100;
	}
}

//text
if drawChar < textLength[page] {
	drawChar += textSpeed;
	drawChar = clamp(drawChar, 0, textLength[page]);
}

//skip dialogue
if interactKey {
	//text typing finished (go to next page)
	if drawChar == textLength[page] {
			//go to next page if there are pages remaining
			if page < pageNumber - 1 {
				page++;
				drawChar = 0;
			}		
			//destroy object if there are no pages left
			else {
					instance_destroy();
			}
	}
	//text skipped but not finished
	else {
		drawChar = textLength[page];
	}
}

//draw the textbox
textboxSprWidth = sprite_get_width(sprTextbox)
textbotSprHeight = sprite_get_height(sprTextbox)

