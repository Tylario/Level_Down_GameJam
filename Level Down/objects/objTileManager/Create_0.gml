lastFloor = -1;


function create_hexagon_ring(centerX, centerY, layer, xDiff, yDiff, floorNum, floorHeight) {
    centerY -= floorNum * floorHeight;
   
    if (layer == 0) {
        var centerTileType = determineTileType(floorNum);
        if (centerTileType != noone) {
            var centerTile = instance_create_layer(centerX, centerY, "Instances", centerTileType);
            centerTile.depth = -centerTile.y + 4000 - (floorNum * 50);
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
           
            var tileType = determineTileType(floorNum); // Determine the tile type for each tile individually

            if (tileType != noone) { 
                var tileInstance = instance_create_layer(posX, posY, "Instances", tileType);
				//show_debug_message("Floor: " + string(floorNum) + ", TileType: " + string(tileType) + ", Position: (" + string(posX) + ", " + string(posY) + ")");
                tileInstance.depth = (-tileInstance.y * 2) + 4000 - (floorNum * 50);
                tileInstance.floorNumber = floorNum;
				if (tileType == objHexagonIce)
				{
					show_debug_message(tileInstance.depth) 
				}

            }
        }
       
        layerStartX += layer * directionX;
        layerStartY += layer * directionY;
    }
}

// Helper function to determine the tile type based on floorNum and randomness
function determineTileType(floorNum) {
    var tileType = noone;
    var randomNumber = irandom(100); // Random number for each tile
  
    switch(floorNum) {
        case 0:
            tileType = objHexagonUnbreakable;
            break;
        case 1:
            if (randomNumber < 80) { 
                tileType = hexagonBreakable;
            }
            break;
        case 2:
            if (randomNumber < 10) tileType = hexagonArrow; 
            else if (randomNumber < 80) tileType = hexagonIce; 
            break;
        case 3:
            if (randomNumber < 60) { 
                tileType = hexagonBreakable;
            }
            break;
        case 4:

            if (randomNumber < 45) { 
                tileType = hexagonBreakable;
            }
			if (randomNumber < 15) { 
                tileType = hexagonArrow;
            }
            break;
        case 5:
           if (randomNumber < 55) { 
                tileType = hexagonIce;
            }
            break;
        case 6:
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
