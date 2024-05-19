if (objPlayer.currentFloor != lastFloor) {
    
    if (objPlayer.currentFloor < 0)
    {
        room_restart();
    }
    
    lastFloor = objPlayer.currentFloor;

    var ringCount = 11;
    var maxFloors = 30; 
    var xDiff = 49; 
    var yDiff = 10; 
    var floorHeight = 100; // Height difference between floors

    // Adjust this to set the center position
    var startX = room_width / 2;
    var startY = room_height - 400;
    
    // Destroy hexagons that are no longer needed
    with (objParentHexagon) 
    { 
        if (floorNumber < objPlayer.currentFloor - 2 || floorNumber >= objPlayer.currentFloor)
        {
            instance_destroy();
        }
    }

    // Adjust ringCount based on the current floor
    if (objPlayer.currentFloor == 0)
    {
        ringCount = 12;
    }
    else
    {
        ringCount = 25;
    }

    // Loop to create each required floor (current and previous two floors)
    for (var f = max(0, objPlayer.currentFloor - 2); f <= objPlayer.currentFloor; f++) 
    {
        for (var i = 0; i <= ringCount; i++) 
        {
            create_hexagon_ring(startX, startY, i, xDiff, yDiff, f, floorHeight);
        }
    }
    
    if (objPlayer.currentFloor != -1) {
        destroyTileLayer(objPlayer.currentFloor);
    }

    // Set opacity of non-current floor hexagons to 50%
    with (objParentHexagon) {
        if (floorNumber != objPlayer.currentFloor) {
            image_alpha = 0.2;
        } else {
            image_alpha = 1; // Ensure hexagons on the current floor are fully opaque
        }
    }
}