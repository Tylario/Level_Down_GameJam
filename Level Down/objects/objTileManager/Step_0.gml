if (objPlayer.currentFloor != lastFloor) {
    lastFloor = objPlayer.currentFloor;

    var layers = 11;
    var floors = 7; 
    var xDiff = 49; 
    var yDiff = 10; 
    var floorHeight = 100; // Height difference between floors

    // Adjust this to set the center position
    var startX = room_width / 2;
    var startY = room_height - 400;
    
    // Destroy all hexagons before creating new ones
    with (objParentHexagon) 
	{ 
		if (floorNumber >= objPlayer.currentFloor)
		{
			instance_destroy();
		}
	}

    // Loop to create each floor
    for (var i = 0; i <= layers; i++) {
        create_hexagon_ring(startX, startY, i, xDiff, yDiff, objPlayer.currentFloor, floorHeight);
    }
    
    if (objPlayer.currentFloor != -1) {
        destroyTileLayer(objPlayer.currentFloor);
    }

    // Set opacity of non-current floor hexagons to 50%
    with (objParentHexagon) {
        if (floorNumber != objPlayer.currentFloor) {
            image_alpha = 0.3;
        } else {
            image_alpha = 1; // Ensure hexagons on the current floor are fully opaque
        }
    }
}
