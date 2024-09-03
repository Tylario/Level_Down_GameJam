//variables
textboxX = camera_get_view_x(view_camera[0]) + (camera_get_view_width(view_camera[0]) / 2) - textboxWidth / 2; //textbox x value
textboxY = camera_get_view_y(view_camera[0]) + (camera_get_view_height(view_camera[0]) / 1.5); //textbox y value

//text setup
if setup == false {
	draw_set_font(fntHabbo);
	draw_set_valign(fa_top);
	draw_set_halign(fa_left);
	draw_set_color(c_white);
	
	//loop through pages
	pageNumber = totalPages();
	for(var p = 0; p < pageNumber; p++) {
		//find how many characters are on each line and store that number in the "textLength" array
		textLength[p] = pageTextLength(p);
	}
}

//typing the text
if drawChar < textLength[page] {
	drawChar += textSpeed;
	drawChar = clamp(drawChar, 0, textLength[page]);
}

//flip through pages
if keyboard_check_pressed(ord("Z")) { //replace with interact key variable
	//if typing is done (go to next page)
	if drawChar == textLength[page] { //meaning page is fully typed out
		//go to next page (if there is a next page)
		if page < pageNumber - 1 {
			page ++;
			drawChar = 0; //reset drawChar for next string of dialogue
		} 
		
		//destroy textbox (no next page)
		else { 
			instance_destroy();
		}
	}
	
	//if not done typing
	else {
		drawChar = textLength[page];
	}
}

//draw textbox
draw_sprite_stretched(sprTextbox, image_index, textboxX, textboxY, textboxWidth, textboxHeight);

//draw text
var drawText = string_copy(textFloor(page), 1, drawChar);
draw_text_ext(textboxX + textBorderX, textboxY + textBorderY, drawText, lineSpaceVertical, lineWidth);

