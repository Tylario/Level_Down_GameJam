lastFloor = -1;


function create_hexagon_ring(centerX, centerY, layer, xDiff, yDiff, floorNum, floorHeight) {
    centerY -= floorNum * floorHeight;
   
    if (layer == 0) 
	{
	    var centerTileType = determineTileType(floorNum, centerX, centerY); // Assuming centerX and centerY passed correctly
	    if (centerTileType != noone) {
	        var centerTile = instance_create_layer(centerX, centerY, "Instances", centerTileType);
	        // Adjusted depth calculation to match other tiles
	        centerTile.depth = (-centerTile.y * 2) + 4000 - (floorNum * 50);
	        centerTile.floorNumber = floorNum;
	    }
	    return;
	}
   
    var layerStartX = centerX + layer * xDiff;
    var layerStartY = centerY;
   
    for (var side = 0; side < 6; side++) {
        var directionX = 0, directionY = 0;
        switch (side) {
            case 0: directionX = -xDiff / 2; directionY = yDiff; break;
            case 1: directionX = -xDiff; break;
            case 2: directionX = -xDiff / 2; directionY = -yDiff; break;
            case 3: directionX = xDiff / 2; directionY = -yDiff; break;
            case 4: directionX = xDiff; break;
            case 5: directionX = xDiff / 2; directionY = yDiff; break;
        }
       
        for (var i = 0; i < layer; i++) {
            var posX = layerStartX + i * directionX;
            var posY = layerStartY + i * directionY;
           
            // Now passing posX and posY
            var tileType = determineTileType(floorNum, posX, posY);

            if (tileType != noone) { 
                var tileInstance = instance_create_layer(posX, posY, "Instances", tileType);
                tileInstance.depth = (-tileInstance.y * 2) + 4000 - (floorNum * 50);
                tileInstance.floorNumber = floorNum;
            }
        }
       
        layerStartX += layer * directionX;
        layerStartY += layer * directionY;
    }
}


// Helper function to determine the tile type based on floorNum and randomness
function determineTileType(floorNum, posX, posY) {
	
	show_debug_message(string(floorNum) + ": " + string(posX) + ", " + string(posY));

    var tileType = noone;
    var randomNumber = irandom(100); // Random number for each tile
  
    switch(floorNum) {
        case 0:
            tileType = objHexagonUnbreakable
			if (posX == 777.50 and posY == 2470)
			{
				tileType = hexagonTrampoline;
			}
            break;
        case 1:
            if (randomNumber < 80) { 
                tileType = hexagonBreakable;
            }
			if (posX == 1096 and posY == 2380)
			{
				tileType = hexagonTrampoline;
			}
            break;
        case 2:
            if (randomNumber < 10) tileType = hexagonArrow; 
            else if (randomNumber < 80) tileType = hexagonIce; 
			if (posX == 1219.50 and posY == 2190)
			{
				tileType = hexagonTrampoline;
			}
            break;
        case 3:
            if (randomNumber < 60) { 
                tileType = hexagonBreakable;
            }
			if (posX == 1194 and posY == 2160)
			{
				tileType = hexagonTrampoline;
			}
            break;
        case 4:
            if (randomNumber < 45) { 
                tileType = hexagonBreakable;
            }
			if (randomNumber < 15) { 
                tileType = hexagonArrow;
            }
			if (posX == 1022.50 and posY == 2090)
			{
				tileType = hexagonTrampoline;
			}
            break;
        case 5:
           if (randomNumber < 55) { 
                tileType = hexagonIce;
            }
			if (posX == 998 and posY == 1840)
			{
				tileType = hexagonTrampoline;
			}
            break;
        case 6:
            tileType = hexagonArrow;
		case 7:
			tileType = hexagonBreakable;
            break;
        default:
            tileType = hexagonArrow;
    }

	
    
    return tileType;
}


function destroyTileLayer(floorNum) {
	show_debug_message(objPlayer.currentFloor)
	show_debug_message(floorNum);
    with (objParentHexagon) { 
        if (floorNumber > floorNum) {
            instance_destroy();
        }
    }
}
