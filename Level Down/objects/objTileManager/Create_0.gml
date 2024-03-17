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
    var tileType = noone;
    var randomNumber = irandom(100); // Random number for each tile
    var floorHeight = 100; // Height difference between floors, adjust if your game uses a different value

    // Checking for a trampoline in the same position on the previous floor
    if (floorNum > 0) {
        var belowPosY = posY + floorHeight; // Calculate the Y position of the tile directly below on the previous floor
        // This checks for a trampoline below and sets this tile to unbreakable if found
        var belowTileType = determineTileType(floorNum - 1, posX, belowPosY);
        if (belowTileType == hexagonTrampoline) {
            return objHexagonUnbreakable; // Force this tile to be an unbreakable hexagon
        }
    }

    // Original tile determination logic with all level setups included
    switch(floorNum) {
        case 0:
            tileType = objHexagonUnbreakable;
            if (posX == 777.50 && posY == 2470) {
                tileType = hexagonTrampoline;
            }
            break;
        case 1:
            if (randomNumber < 90) { 
                tileType = hexagonBreakable;
            } else if (randomNumber < 5) { 
                tileType = hexagonArrow;
            }
            if (posX == 1096 && posY == 2380) {
                tileType = hexagonTrampoline;
            }
            break;
        case 2:
            if (randomNumber < 10) {
                tileType = hexagonArrow; 
            } else if (randomNumber < 90) {
                tileType = hexagonIce; 
            }
            if (posX == 1219.50 && posY == 2190) {
                tileType = hexagonTrampoline;
            }
            break;
        case 3:
            if (randomNumber < 60) { 
                tileType = hexagonBreakable;
            }
            if (posX == 1194 && posY == 2160) {
                tileType = hexagonTrampoline;
            }
            break;
        case 4:
            if (randomNumber < 45) { 
                tileType = hexagonBreakable;
            } else if (randomNumber < 15) { 
                tileType = hexagonArrow;
            }
            if (posX == 1022.50 && posY == 2090) {
                tileType = hexagonTrampoline;
            }
            break;
        case 5:
            if (randomNumber < 55) { 
                tileType = hexagonIce;
            }
            if (posX == 998 && posY == 1840) {
                tileType = hexagonTrampoline;
            }
            break;
        case 6:
            tileType = hexagonArrow; // Assuming an arbitrary rule for simplicity
            break;
        case 7:
            tileType = hexagonBreakable; // Another arbitrary rule for this floor
            break;
        default:
            tileType = hexagonArrow; // Default case if none of the above conditions are met
    }

    return tileType;
}



function destroyTileLayer(floorNum) {
    with (objParentHexagon) { 
        if (floorNumber > floorNum) {
            instance_destroy();
        }
    }
}


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
		if (floorNumber > objPlayer.currentFloor)
		{
			instance_destroy();
		}
	}

    // Loop to create each floor
    for (var floorNum = 0; floorNum < floors; floorNum++) {
        for (var i = 0; i <= layers; i++) {
            create_hexagon_ring(startX, startY, i, xDiff, yDiff, floorNum, floorHeight);
        }
    }