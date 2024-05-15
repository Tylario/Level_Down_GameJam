lastFloor = -1;


function create_hexagon_ring(centerX, centerY, layer, xDiff, yDiff, floorNum, floorHeight) 
{
    centerY -= floorNum * floorHeight;
   
    if (layer == 0) {
        var centerTileType = determineTileType(floorNum, centerX, centerY); // Assuming centerX and centerY passed correctly
        if (centerTileType != noone) {
            var centerTile = instance_create_layer(centerX, centerY, "Instances", centerTileType);
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
           
            // Determine if this is the outermost layer on floor 0
            var isOutermostLayerOnFloor0;
			
		if (floorNum == 0 && (layer == 14 or layer == 13)) {
		    isOutermostLayerOnFloor0 = true;
		} else {
		    isOutermostLayerOnFloor0 = false;
		}

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


function determineTileType(floorNum, posX, posY, isCheckingBelow = false) {
    var difficulty = 1 - (0.02 * floorNum);
    var chanceForEmpty = 1 - difficulty;
    //var randomNumber = irandom(100); // Random number for each tile

    // Adjust trampoline positioning logic for floor height
    var floorHeight = 100; // Height difference between floors
    var adjustedFloorHeight = floorHeight * floorNum; // Adjust for current floorNum
    
    var trampolineX, trampolineY;
    if (floorNum % 2 == 0) { // Alternating trampoline positions based on even or odd floorNum
        trampolineX = 777.50 - (49 * 2.5); // Adjusted for X position
        trampolineY = (2470 - (2 * 40 - 10)) - adjustedFloorHeight; // Adjusted for Y position, accounting for floor height
    } else {
        trampolineX = 777.50 + (49 * 7.5); // Adjusted for X position
        trampolineY = (2470 - (2 * 40 - 10)) - adjustedFloorHeight; // Adjusted for Y position, accounting for floor height
    }


    var tileType = noone;

// Check for trampolines below if not already checking below (to prevent infinite recursion)
    if (floorNum > 0 && !isCheckingBelow) {
        var xDiff = 49; 
        var yDiff = 10;
        
        var belowPosY = posY + floorHeight; // Calculate the Y position of the tile directly below on the previous floor
        var isTrampolineBelow = false;

        // Modify these checks to pass 'true' for the isCheckingBelow parameter
        if (determineTileType(floorNum - 1, posX, belowPosY, true) == hexagonTrampoline) {
            return hexagonFloorNumber;
        } else if (determineTileType(floorNum - 1, posX - xDiff / 2, belowPosY + yDiff, true) == hexagonTrampoline) {
            isTrampolineBelow = true;
        } else if (determineTileType(floorNum - 1, posX + xDiff / 2, belowPosY + yDiff, true) == hexagonTrampoline) {
            isTrampolineBelow = true;
        } else if (determineTileType(floorNum - 1, posX, belowPosY + yDiff * 2, true) == hexagonTrampoline) {
            isTrampolineBelow = true;
        } else if (determineTileType(floorNum - 1, posX, belowPosY - yDiff * 2, true) == hexagonTrampoline) {
            isTrampolineBelow = true;
        } else if (determineTileType(floorNum - 1, posX - xDiff / 2, belowPosY - yDiff, true) == hexagonTrampoline) {
            isTrampolineBelow = true;
        } else if (determineTileType(floorNum - 1, posX + xDiff / 2, belowPosY - yDiff, true) == hexagonTrampoline) {
            isTrampolineBelow = true;
        }

        if (isTrampolineBelow) {
            // Ensure unbreakable tiles are spawned above trampolines
            // No additional check required here as isTrampolineBelow flag covers it
            return objHexagonUnbreakable; // Force this tile to be an unbreakable hexagon
        }
    }



    // Tile type based on level logic
	var levelType = floorNum % 5;

	if (floorNum == 0 || levelType == 0) {
	    tileType = hexagonUnbreakable;
	} else {
	    var noiseValue = perlin_noise(posX * 0.015, posY * 0.015, floorNum * 0.015); // Adjust the scaling factors as needed
		//var noiseValue = irandom_range(-1, 1);
		if (noiseValue > -0.2 + (floorNum * 0.02)) {
	        tileType = hexagonBreakable;
	    } else {
	        tileType = noone;
	    }
	}


    // Ensuring trampoline spawns on each floor based on adjusted trampolineX and trampolineY positions
    if (posX == trampolineX && posY == trampolineY) {
        tileType = hexagonTrampoline;
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
	if (floorNumber > objPlayer.curreloor)
	{
		instance_destroy();
	}
}

// Loop to create each floor
for (var floorNum = 0; floorNum < floors; floorNum++) 
{
	if (floorNum == 0)
	{
		layers = 14;
	}
	else
	{
		layers = 11;
	}
    for (var i = 0; i <= layers; i++) 
	{
        create_hexagon_ring(startX, startY, i, xDiff, yDiff, floorNum, floorHeight);
    }
}