if (objPlayer.currentFloor != lastFloor) 
{
    lastFloor = objPlayer.currentFloor;

	var layers = 11;
	var floors = 6; 
	var xDiff = 49; 
	var yDiff = 10; 
	var floorHeight = 100; // Height difference between floors

	// Adjust this to set the center position
	var startX = room_width / 2;
	var startY = room_height - 400;

	// Loop to create each floor
	for (var floorNum = 0; floorNum < floors; floorNum++) 
	{
	    for (var i = 0; i <= layers; i++) 
		{
	        create_hexagon_ring(startX, startY, i, xDiff, yDiff, floorNum, floorHeight);
	    }
	}
	
	if (lastFloor != -1)
	{
		destroyTileLayer(lastFloor);
	}
}