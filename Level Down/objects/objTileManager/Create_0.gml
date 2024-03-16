lastFloor = -1;


// Function to create a ring of hexagons including the center tile, now also accepts floorHeight
	function create_hexagon_ring(centerX, centerY, layer, xDiff, yDiff, floorNum, floorHeight) {
	    // Adjust centerY based on the floor number and floorHeight
	    centerY -= floorNum * floorHeight;

	    var tileType; // Declare variable for tile type

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
	        default: // For floor 3 and above
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