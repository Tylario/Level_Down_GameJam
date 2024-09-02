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