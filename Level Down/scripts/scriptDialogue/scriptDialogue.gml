//function that determines the correct dialogue array to use depending on the current floor
function textFloor(p){ //p is the current page number
	f = objPlayer.currentFloor;
	
	if f == 0 {
		return textFloor0[p];
	}
	
	else if f == 5 {
		return textFloor5[p];
	} 
	
	else if f == 10 {
		return textFloor10[p];
	}
	
	else if f == 15 {
		return textFloor15[p];
	}
	
	else if f == 20 {
		return textFloor20[p];
	}
	
	else if f == 25 {
		return textFloor25[p];
	}
	
	else if f == 30 {
		return textFloor30[p];
	}
	
	else if f == 35 {
		return textFloor35[p];
	}
	
	else if f == 40 {
		return textFloor40[p];
	}
	
	else if f == 45 {
		return textFloor45[p];
	}
	
	else if f == 50 {
		return textFloor50[p];
	}
	
	else if f == 55 {
		return textFloor55[p];
	}
	
	else if f == 60 {
		return textFloor60[p];
	}
	
	else if f == 65 {
		return textFloor65[p];
	}
	
	else if f == 70 {
		return textFloor70[p];
	}
	
	else if f == 75 {
		return textFloor75[p];
	}
	
	else if f == 80 {
		return textFloor80[p];
	}
	
	else if f == 85 {
		return textFloor85[p];
	}
	
	else if f == 90 {
		return textFloor90[p];
	}
	
	else if f == 95 {
		return textFloor95[p];
	}
	
	else if f == 100 {
		return textFloor100[p];
	}
	
	else {
		show_debug_message("ScriptDialogue textFloor function failed to return the correct array for the floor the player is currently on.");
	}
	
}

//function that returns entire text array for a given floor
function totalPages() { 
	f = objPlayer.currentFloor;
	
	if f == 0 {
		return array_length(textFloor0);
	} 
	
	else if f == 5 {
		return array_length(textFloor5);
	} 
	
	else {
		return array_length(textFloor10);
	}
}

//function that returns the length of the string on a given page
function pageTextLength(p) { //p is the current page number
	return string_length(textFloor(p));
}