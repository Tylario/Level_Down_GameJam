global.starLocationsArray = [];
global.planetsLocationsArray = [];
global.locationsArray = [];

//calling this function uses the placeSprite() function to place planets and stars in the background of the room
function background() {
	
	//array of star sprites and amount to spawn
	var starArray = [sprStar1, sprStar2, sprStar3, sprStar4, sprStar5, sprStar6];
	var starNumber = 3000;
	var starOffset = 10;
	
	//array of planet sprites and amount to spawn
	var planetArray = [sprPlanet1, sprPlanet2, sprPlanet3, sprPlanet4, sprPlanet5, sprPlanet6, sprPlanet7, sprPlanet8, sprPlanet9, sprPlanet10];
	var planetNumber = 900;
	var planetOffset = 100;
	
	placeSprite(planetNumber, planetArray, "Planets", planetOffset, global.locationsArray);
	placeSprite(starNumber, starArray, "Stars", starOffset, global.locationsArray);
	
	
	
}

//calling this function places sprites within a given array at random locations within the room on a specified layer
function placeSprite(spriteAmount, spriteArray, layerName, offset, locationsArray) {
	var xVal;
	var yVal;
	
	for (i = 0; i < spriteAmount; i++) {
		xVal = irandom_range(0, room_width);
		yVal = irandom_range(0, room_height);
		
		if (checkOverlap(xVal, yVal, offset, locationsArray)) {
			layer_sprite_create(layerName, xVal, yVal, spriteArray[irandom(array_length(spriteArray) - 1)]);	
			array_push(locationsArray, [xVal, yVal]);
		}
	}
}


function checkOverlap(xVal, yVal, offset, locationsArray) {
	for (j = 0; j < array_length(locationsArray); j++) {
		if (abs(locationsArray[j][0] - xVal) < offset && abs(locationsArray[j][1] - yVal) < offset) {
			return false;
			show_debug_message("False match");
		}
	}
	
	return true;
}