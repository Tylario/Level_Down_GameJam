if (objPlayer.currentFloor != lastFloor) 
{
    lastFloor = objPlayer.currentFloor;

	var layers = 11;
	var floors = 4; // Updated to include floor 3 as an example
	var xDiff = 49; // Adjust based on the width of your hexagon tiles
	var yDiff = 10; // Adjust based on the height difference between the centers of adjacent hexagon tiles
	var floorHeight = 200; // Height difference between floors

	// Adjust this to set the center position
	var startX = room_width / 2;
	var startY = room_height - 400;

	// Loop to create each floor
	for (var floorNum = 0; floorNum < floors; floorNum++) {
	    // Create the center tile for each floor
	    create_hexagon_ring(startX, startY, 0, xDiff, yDiff, floorNum, floorHeight);

	    // Create layers of tiles for each floor
	    for (var i = 1; i <= layers; i++) {
	        create_hexagon_ring(startX, startY, i, xDiff, yDiff, floorNum, floorHeight);
	    }
	}
}