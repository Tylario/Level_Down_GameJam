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
		
		if (determineTileType(floorNum, posX - xDiff / 2, posY + yDiff, true) == hexagonTrampoline) {
            isTrampolineBelow = true;
        } else if (determineTileType(floorNum, posX + xDiff / 2, posY + yDiff, true) == hexagonTrampoline) {
            isTrampolineBelow = true;
        } else if (determineTileType(floorNum, posX, posY + yDiff * 2, true) == hexagonTrampoline) {
            isTrampolineBelow = true;
        } else if (determineTileType(floorNum, posX, posY - yDiff * 2, true) == hexagonTrampoline) {
            isTrampolineBelow = true;
        } else if (determineTileType(floorNum, posX - xDiff / 2, posY - yDiff, true) == hexagonTrampoline) {
            isTrampolineBelow = true;
        } else if (determineTileType(floorNum, posX + xDiff / 2, posY - yDiff, true) == hexagonTrampoline) {
            isTrampolineBelow = true;
        }

        if (isTrampolineBelow) {
            // Ensure unbreakable tiles are spawned above trampolines
            // No additional check required here as isTrampolineBelow flag covers it
            return objHexagonUnbreakable; // Force this tile to be an unbreakable hexagon
        }
    }
	
	// Ensuring trampoline spawns on each floor based on adjusted trampolineX and trampolineY positions
    if (posX == trampolineX && posY == trampolineY) {
        return hexagonTrampoline;
    }
	
	if (floorNum % 5 == 0) 
	{
	    return hexagonUnbreakable;
	}


	//Level design / Tile Generation Starts here
	/* 
		i want a difficulty variable. increases overtime, and repeats between checkpoints. something like difficulty = floorNum + (5 % floorNum)	
		every 7 levels floorNum % 7 it needs to include hexagonWall
		needs to be the same each time. so uses seeded random values with floorNum or the perlin Noise function like below is great
		things we can do:
		ranges within perlin noise. middle values for rings/paths, low/high values for holes. 
		i like the idea of layering different perlin_noises over eachother at different scales
		also using a different scale value for perlin noise
		floor tile types (hexagonUnbreakable, hexagonBreakable,hexagonIce )
		 - first 5 level should be mostly hexagonUnbreakable
		 -  hexagonUnbreakable will completely cover every 5th level. nothing shoudl appear on these levels other than unbrekable
		 - ice is rareish, maybe appear in 1/4 levels i have it to appear on the last of each set of levels
		 - 
		some levels should include these. levels can have multiple of these at once. maybe each one of these occurs every n levels
		 - these should be randomly scattered, probably, only being places where the main ground is, so they arent floating by themselves
		 (flooat uniqieu tile types: hexagonArrow, hexagonJump, hexagonDeadly)
		 
	*/
	
	
	else if (floorNum % 7 == 0)
	{
		var noiseValue = perlin_noise(posX * 0.06, posY * 0.06, floorNum * 0.015); // Adjust the scaling factors as needed
		if (noiseValue > -0.4)
		{
			tileType = hexagonUnbreakable;
		}
		else
		{
			tileType = hexagonWall
		}
	}
	else if (floorNum == 1)
	{
		var noiseValue = perlin_noise(posX * 0.06, posY * 0.06, floorNum * 0.015); // Adjust the scaling factors as needed
		if (noiseValue > -0.4)
		{
			tileType = hexagonUnbreakable;
		}
		else
		{
			random_set_seed(floorNum + posX + posY);
			var noiseValue2 = irandom_range(0, 100);
			if (noiseValue2 < 25)
			{
				tileType = hexagonWall
			}
			else if (noiseValue2 < 50)
			{
				tileType = hexagonDeadly
			}
			else if (noiseValue2 < 75)
			{
				tileType = hexagonJump
			}
			else
			{
				tileType = hexagonArrow
			}	
		}
	}
	else {
	    var noiseValue = perlin_noise(posX * 0.015, posY * 0.015, floorNum * 0.015); // Adjust the scaling factors as needed
		if (noiseValue > -0.3 + (floorNum * 0.02)) {
	        if (floorNum % 5 == 4)
			{
				tileType = objHexagonIce
			}
			else
			{
				tileType = objHexBreakable
			}
	    } else {
	        tileType = noone;
	    }
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

