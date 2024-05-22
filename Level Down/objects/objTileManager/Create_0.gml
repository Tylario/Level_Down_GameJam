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


function determineTileType(floorNum, posX, posY, isCheckingBelow = false) 
{
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
	//variable definitinos for tile generation
	var wallFloor = false; // every 7 floors
	var wallTilePercentage; // percentage change for a tile that would have been floor to be wall
	var wallTilePercentageMin = 0.01;
	var wallTilePercentageMax = 0.02;
	var arrowFloor = false; // every 9 and 13 floors
	var arrowPercentage; //percentage change for tile that would have been floor to be arrow
	var arrowPercentageMin = 0.02;
	var arrowPercentageMax = 0.12;
	var deadlyFloor = false; // every 8 floors
	var deadlyPercentage; //percentage change for tile that would have been floor to be deadly
	var deadlyPercentageMin = 0.01;
	var deadlyPercentageMax = 0.04;
	var jumpFloor = false; // every every 11 and 14 floors
	var jumpPercentage; // percentage change for tile that would have been floor to be jump
	var jumpPercentageMin = 0.005;
	var jumpPercentageMax = 0.01;
	
	var NoiseType; // middle range, or greater/less than value
	var NoiseScale = 0.02;//0.005 min, 0.025 max
	var layered = false; //regular perlin noise, or 3 perlin noise, x2 frequency, /2 amplitude for 2nd, and 3rd
	var unbreakableFloor = true; // first 5 floors. every 12 and 17 floors
	var breakableFloor = true; // true if ice is false. 25% of the time true is ice is true
	var iceFloor = false; // true if floorNum % 5 == 4, and every 6 floors
	var difficultyNumber = 35 + floorNum + ((floorNum % 5) * 5);// difficulty starting at 0 
	var difficultyScale = 0.015;
	
	//variable implementation
	// Set the seed for deterministic randomness based on floor number and tile position
	random_set_seed(floorNum);

	// Determine the properties for special tiles on certain floors
	wallFloor = floorNum % 7 == 0;
	arrowFloor = floorNum > 5 && ((floorNum % 9 == 0) || (floorNum % 12 == 0) || (floorNum % 9 == 4));
	deadlyFloor = (floorNum > 10) && ((floorNum % 8 == 0) || (floorNum % 8 == 5));
	jumpFloor = floorNum > 5 &&  ((floorNum % 11 == 0 || floorNum % 13 == 0 || floorNum % 11 == 7)|| floorNum % 11 == 3);
	
	iceFloor = (floorNum % 5 == 4 and floorNum > 5) || (floorNum % 6 == 0);
	unbreakableFloor = (floorNum <= 4) || (floorNum % 12 == 0) || (floorNum % 17 == 0);

	// Calculate the percentages for each tile type transformation
	wallTilePercentage = random_range(wallTilePercentageMin, wallTilePercentageMax);
	arrowPercentage = random_range(arrowPercentageMin, arrowPercentageMax);
	deadlyPercentage = random_range(deadlyPercentageMin, deadlyPercentageMax);
	jumpPercentage = random_range(jumpPercentageMin, jumpPercentageMax);
	
	// Noise settings using floor-only seed for consistency across a single floor

	NoiseScale = random_range(0.012, 0.019);
	//NoiseScale = 0.02;

	// Tile-specific settings

	// Generate the base noise value for this tile
	var noiseValue = perlin_noise(posX * NoiseScale, posY * NoiseScale, floorNum * NoiseScale);


	// Apply normal logic for tile type determination
	if (unbreakableFloor) {
			if (arrowFloor)
			{
				difficultyNumber = difficultyNumber * 0.6
			}
	        if (noiseValue > -1 + difficultyScale * difficultyNumber) {
	            tileType = hexagonUnbreakable;
	        }
			arrowPercentageMax = arrowPercentageMax * 3;
	} else  if (iceFloor) {
	   
	        if (noiseValue > -1 + difficultyScale * difficultyNumber) {
	            tileType = objHexagonIce;
	        }
	} else {
	   
	        if (noiseValue > -1 + difficultyScale * difficultyNumber) {
	            tileType = objHexBreakable;
	        }
	} 

	random_set_seed(floorNum * 100 + posX * 10 + posY);


	// Check for special tile types if the basic tile type has been set to a breakable or unbreakable type
	if (tileType != noone) {
	    if (wallFloor && irandom_range(0, 100) < wallTilePercentageMax * 100) {
	        tileType = hexagonWall;
	    }
	    if (arrowFloor && irandom_range(0, 100) < arrowPercentage * 100) {
	        tileType = hexagonArrow;
	    }
	    if (deadlyFloor && irandom_range(0, 100) < deadlyPercentage * 100) {
	        tileType = hexagonDeadly;
	    }
	    if (jumpFloor && irandom_range(0, 100) < jumpPercentage * 10) {
	        tileType = hexagonJump;
	    }
	}

	// Return the final determined tile type
	return tileType;


}



function destroyTileLayer(floorNum) {
    with (objParentHexagon) { 
        if (floorNumber > floorNum) {
            instance_destroy();
        }
    }
}

