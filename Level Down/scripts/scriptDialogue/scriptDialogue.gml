//function that determines the correct dialogue array to use depending on the current floor
function textFloor(p){ //p is the current page number
	f = objPlayer.currentFloor;
	
	if f == 0 {
		return textFloor0[p];
	} 
	
	else if f == 5 {
		return textFloor5[p];
	} 
	
	else {
		return textFloor10[p];
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