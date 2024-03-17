lastFloor = -1;


function create_hexagon_ring(centerX, centerY, layer, xDiff, yDiff, floorNum, floorHeight) {

    centerY -= floorNum * floorHeight;
	
	show_debug_message(floorNum);

    var tileType; 

    // Determine the tile type based on the floor number
    switch(floorNum) {
        case 0:
            tileType = objHexagonUnbreakable;
            break;
        case 1:
            tileType = hexagonBreakable;
            break;
        case 2:
            tileType = hexagonIce;
            break;
		case 3:
			tileType = hexagonArrow;
			break;
		case 4:
			tileType = hexagonIce;
			break;
		case 5:
			tileType = hexagonBreakable;
			break;
		case 6:
			tileType = hexagonBreakable;
			break;
        default:
            tileType = hexagonArrow;
    }
    // If it's the first layer, create the center tile
    if (layer == 0) {
        var centerTile = instance_create_layer(centerX, centerY, "Instances", tileType);
        centerTile.depth = -centerTile.y + 4000 - (floorNum * 1000);
        centerTile.floorNumber = floorNum; // Set the floorNumber variable for the tile
        return; // Exit the function after creating the center tile
    }
   
    // Determine the starting position for this layer
    var layerStartX = centerX + layer * xDiff;
    var layerStartY = centerY;
   
    for (var side = 0; side < 6; side++) {
        var directionX = 0;
        var directionY = 0;
       
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
           
            // Create the tile and adjust its depth for rendering order
            var tileInstance = instance_create_layer(posX, posY, "Instances", tileType);
            tileInstance.depth = -tileInstance.y + 4000 - (floorNum * 1000);
            tileInstance.floorNumber = floorNum; // Set the floorNumber variable for the tile
        }
       
        layerStartX += layer * directionX;
        layerStartY += layer * directionY;
    }
}
	

function destroyTileLayer(floorNum) {
    with (objParentHexagon) { 
        if (floorNumber > floorNum) {
            instance_destroy();
        }
    }
}
