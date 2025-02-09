// OPTIMIZATION VARIABLE. 
	// if false, it will render just the level you are on
	// if true, it will render also render the level below, but mostly transparent
renderTwoLayers = true;

lastFloor = -1;


function create_hexagon_ring(centerX, centerY, layer, xDiff, yDiff, floorNum, floorHeight) 
{
    centerY -= floorNum * floorHeight;
   
    if (layer == 0) {
        var centerTileType = determineTileType(floorNum, centerX, centerY); // Assuming centerX and centerY passed correctly
        if (centerTileType != noone) {
            var centerTile = instance_create_layer(centerX, centerY, "Instances", centerTileType);
            centerTile.depth = (-centerTile.y * 2) + 34000 - (floorNum * 50);
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
			
			if (floorNum % 5 == 0)
			{
				// checkpoint level
				if (layer == 16 or layer == 15)
				{
					var tileType = hexagonWall;
				}
				else
				{
					var tileType = determineTileType(floorNum, posX, posY);
				}
			}
			else
			{
				//non checkpoint level
				if (layer == 12 or layer == 13)
				{
					var tileType = noone;
				}
				else if (layer == 14 or layer == 15)
				{
					//var tileType = hexagonInvisibleWall
					var tileType = hexagonWall
				}
				else
				{
					var tileType = determineTileType(floorNum, posX, posY);
				}
			}

            if (tileType != noone) { 
                var tileInstance = instance_create_layer(posX, posY, "Instances", tileType);
                tileInstance.depth = (-tileInstance.y * 2) + 34000 - (floorNum * 50);
                tileInstance.floorNumber = floorNum;		

            }
        }
       
        layerStartX += layer * directionX;
        layerStartY += layer * directionY;
    }
}

crackedChance = 0
trampolineChance = 0
arrowChance = 0
wallChance = 0
breakableChance = 0
unbreakableChance = 0
iceChance = 0
solidIceChance = 0
fallChance = 0
breakIceChance = 0
hologramSlowChance = 0;
lowGravityChance = 0;

function determineTileType(floorNum, posX, posY, isCheckingBelow = false) 
{
	var tileType = noone; // Default to no tile type

    // Adjust trampoline positioning logic for floor height
    var floorHeight = 100; // Height difference between floors
    var adjustedFloorHeight = floorHeight * floorNum; // Adjust for current floorNum

	
    var trampolineX, trampolineY;
    if (floorNum % 2 == 0) { // Alternating trampoline positions based on even or odd floorNum
        trampolineX = 900 - (48 * 5) 
        trampolineY = 14600 - adjustedFloorHeight; 
    } else {
        trampolineX = 900 + (48 * 5);
        trampolineY = 14600 - adjustedFloorHeight;
    }


	// Check for trampolines below if not already checking below (to prevent infinite recursion)
    if (floorNum > 0 && !isCheckingBelow) {
        var xDiff = 48; 
        var yDiff = 10.5;
        
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
    if (posX == trampolineX && posY == trampolineY && floorNum < 100) {
        return hexagonTrampoline;
    }
	
	if (floorNum % 5 == 0) 
	{
		if (layer > 5)
		{
			return noone
		}
		else
		{
			return objHexagonUnbreakableDesign;
		}
	}

	//Level design / Tile Generation Starts here
	switch (floorNum) {
		case 0:
			tileType = hexagonUnbreakable;
			break;
		case 1:
			crackedChance = 0
			trampolineChance = 0
			arrowChance = 0
			wallChance = 0
			breakableChance = 0
			unbreakableChance = 1;
			breakIceChance = 0; 
			solidIceChance = 0; 
			iceChance = 0;
			fallChance = 0
			nothingChance = 0;
			hologramSlowChance = 0;
			lowGravityChance = 0; 
			tileType = perlinLevelGeneration(0.16, posX, posY, floorNum, 157, 0.2, hexagonUnbreakable, "inner");
			break;
		case 2:
			crackedChance = 0
			trampolineChance = 0
			arrowChance = 0
			wallChance = 0
			breakableChance = 0
			unbreakableChance = 1
			breakIceChance = 0; 
			solidIceChance = 0; 
			iceChance = 0
			fallChance = 0
			nothingChance = 0;  
			hologramSlowChance = 0;
			tileType = perlinLevelGeneration(0.25, posX, posY, floorNum, 0, 0.2, hexagonUnbreakable, "inner");
			break;
		case 3:
			crackedChance = 0
			trampolineChance = 0
			arrowChance = 0
			wallChance = 0
			breakableChance = 0.1
			unbreakableChance = 1
			breakIceChance = 0; 
			solidIceChance = 0; 
			iceChance = 0
			fallChance = 0
			nothingChance = 0;  
			hologramSlowChance = 0;
			lowGravityChance = 0; 
			tileType = perlinLevelGeneration(0.23, posX, posY, floorNum, 0, 0.5, hexagonUnbreakable, "inner");
			break;
		case 4:
			crackedChance = 0
			trampolineChance = 0
			arrowChance = 0
			wallChance = 0
			breakableChance = 0.2
			unbreakableChance = 1
			breakIceChance = 0; 
			solidIceChance = 0; 
			iceChance = 0
			fallChance = 0
			nothingChance = 0;  
			hologramSlowChance = 0;
			lowGravityChance = 0; 
			tileType = perlinLevelGeneration(0.27, posX, posY, floorNum, 0, 0.1, hexagonBreakable, "half");
			break;
		case 5:
			lowGravityChance = 0; 
			tileType = hexagonUnbreakable;
			break;
		case 6:
			crackedChance = 0
			trampolineChance = 0
			arrowChance = 0.0
			wallChance = 0
			breakableChance = 0
			unbreakableChance = 0;
			breakIceChance = 0; 
			solidIceChance = 1; 
			iceChance = 0
			fallChance = 0
			nothingChance = 0;  
			hologramSlowChance = 0;
			lowGravityChance = 0;
			tileType = perlinLevelGeneration(0.16, posX, posY, floorNum, 0, 0.7, hexagonUnbreakable, "inner");
			break;
		case 7:
			crackedChance = 0
			trampolineChance = 0
			arrowChance = 0
			wallChance = 0
			breakableChance = 0
			unbreakableChance = 0
			breakIceChance = 0; 
			solidIceChance = 1; 
			iceChance = 0
			fallChance = 0
			nothingChance = 0; 
			hologramSlowChance = 0;
			lowGravityChance = 0;
			lowGravityChance = 0; 
			tileType = perlinLevelGeneration(0.45, posX, posY, floorNum, 0, 0.05, hexagonBreakable, "half");
			break;
		case 8:
			crackedChance = 0
			trampolineChance = 0
			arrowChance = 0.05
			wallChance = 0
			breakableChance = 0
			unbreakableChance = 0
			breakIceChance = 0; 
			solidIceChance = 1; 
			iceChance = 0
			fallChance = 0
			nothingChance = 0;  
			hologramSlowChance = 0;
			lowGravityChance = 0;
			tileType = perlinLevelGeneration(0.30, posX, posY, floorNum, 0, 0.1, hexagonUnbreakable, "inner");
			break;
		case 9:
			crackedChance = 0
			trampolineChance = 0
			arrowChance = 0.1
			wallChance = 0
			breakableChance = 0
			unbreakableChance = 0
			breakIceChance = 0; 
			solidIceChance = 1;
			iceChance = 0
			fallChance = 0
			nothingChance = 0;  
			hologramSlowChance = 0;
			lowGravityChance = 0; 
			tileType = perlinLevelGeneration(0.33, posX, posY, floorNum, 0, 0.49, hexagonBreakable, "half");
			break;
		case 10:
			tileType = hexagonUnbreakable;
			break;
		case 11:
			crackedChance = 0
			trampolineChance = 0
			arrowChance = 0
			wallChance = 0
			breakableChance = 0
			unbreakableChance = 0
			breakIceChance = 1; 
			solidIceChance = 0; 
			iceChance = 0
			fallChance = 0
			nothingChance = 0;  
			hologramSlowChance = 0;
			lowGravityChance = 0; 
			tileType = perlinLevelGeneration(0.25, posX, posY, floorNum, 0, 0.48, hexagonIce, "inner");
			break;
		case 12:
			crackedChance = 0
			trampolineChance = 0
			arrowChance = 0
			wallChance = 0
			breakableChance = 0
			unbreakableChance = 0
			breakIceChance = 1; 
			solidIceChance = 0; 
			iceChance = 0
			fallChance = 0
			nothingChance = 0;  
			hologramSlowChance = 0;
			lowGravityChance = 0; 
			tileType = perlinLevelGeneration(0.25, posX, posY, floorNum, 125, 0.01, hexagonIce, "half");
			break;
		case 13:
			crackedChance = 0
			trampolineChance = 0
			arrowChance = 0.0
			wallChance = 0
			breakableChance = 0
			unbreakableChance = 0
			breakIceChance = 1; 
			solidIceChance = 0; 
			iceChance = 0
			fallChance = 0
			nothingChance = 0;  
			hologramSlowChance = 0;
			lowGravityChance = 0;
			tileType = perlinLevelGeneration(0.3, posX, posY, floorNum, 0, 0.1, hexagonBreakable, "half");
			break;
		case 14:
			crackedChance = 0
			trampolineChance = 0
			arrowChance = 0.07
			wallChance = 0
			breakableChance = 0
			unbreakableChance = 0
			breakIceChance = 1; 
			solidIceChance = 0; 
			iceChance = 0
			fallChance = 0
			nothingChance = 0;  
			hologramSlowChance = 0;
			lowGravityChance = 0;
			lowGravityChance = 0; 
			tileType = perlinLevelGeneration(0.3, posX, posY, floorNum, 400, 0.05, hexagonIce, "inner");
			break;
		case 15:
			tileType = hexagonUnbreakable;
			break;
		case 16:
			crackedChance = 0
			trampolineChance = 0
			arrowChance = 0
			wallChance = 0.05
			breakableChance = 1
			unbreakableChance = 0.1
			breakIceChance = 0; 
			solidIceChance = 0; 
			iceChance = 0
			fallChance = 0
			nothingChance = 0; 
			hologramSlowChance = 0;
			lowGravityChance = 0; 
			tileType = perlinLevelGeneration(0.30, posX, posY, floorNum, 0, 0.30, hexagonUnbreakable, "outer", objHexagonUnbreakable);
			break;
		case 17:
			crackedChance = 0
			trampolineChance = 0
			arrowChance = 0
			wallChance = 0.02
			breakableChance = 1
			unbreakableChance = 0
			breakIceChance = 0; 
			solidIceChance = 0; 
			iceChance = 0
			fallChance = 0
			nothingChance = 0;  
			hologramSlowChance = 0;
			lowGravityChance = 0;
			tileType = perlinLevelGeneration(0, posX, posY, floorNum, 0, 0.21, hexagonUnbreakable, "inner");
			break;
		case 18:
			crackedChance = 0
			trampolineChance = 0
			arrowChance = 0
			wallChance = 0.05
			breakableChance = 1
			unbreakableChance = 0
			breakIceChance = 0; 
			solidIceChance = 0; 
			iceChance = 0
			fallChance = 0
			nothingChance = 0;  
			hologramSlowChance = 0; 
			tileType = perlinLevelGeneration(0.27, posX, posY, floorNum, 10, 0.22, hexagonIce, "half");
			break;
		case 19:
			crackedChance = 0
			trampolineChance = 0
			arrowChance = 0
			wallChance = 0.05
			breakableChance = 1
			unbreakableChance = 0
			breakIceChance = 0; 
			solidIceChance = 0; 
			iceChance = 0
			fallChance = 0
			nothingChance = 0;  
			hologramSlowChance = 0;
			lowGravityChance = 0; 
			tileType = perlinLevelGeneration(0.27, posX, posY, floorNum, 100, 0.33, hexagonBreakable, "inner");
			break;
		case 20:
			tileType = hexagonUnbreakable;
			break;
		case 21:
			crackedChance = 0
			trampolineChance = 0
			arrowChance = 0
			wallChance = 0
			breakableChance = 1
			unbreakableChance = 0
			breakIceChance = 0; 
			solidIceChance = 0; 
			iceChance = 0
			fallChance = 0.075
			nothingChance = 0;  
			hologramSlowChance = 0;
			lowGravityChance = 0; 
			tileType = perlinLevelGeneration(0.34, posX, posY, floorNum, 0, 0.57, hexagonUnbreakable, "outer", objHexagonUnbreakable);
			break;
		case 22:
			crackedChance = 0
			trampolineChance = 0.0
			arrowChance = 0.03
			wallChance = 0
			breakableChance = 0
			unbreakableChance = 0
			breakIceChance = 1;
			solidIceChance = 0 
			iceChance = 0
			fallChance = 0
			nothingChance = 0; 
			hologramSlowChance = 0;
			lowGravityChance = 0; 
			tileType = perlinLevelGeneration(0.32, posX, posY, floorNum, 0, 0.28, hexagonBreakable, "half");
			break;
		case 23:
			crackedChance = 0
			trampolineChance = 0.0005
			arrowChance = 0
			wallChance = 0
			breakableChance = 0
			unbreakableChance = 0
			breakIceChance = 0; 
			solidIceChance = 0; 
			iceChance = 1
			fallChance = 0
			nothingChance = 0;  
			hologramSlowChance = 0;
			lowGravityChance = 0; 
			tileType = perlinLevelGeneration(0.24, posX, posY, floorNum, 200, 0.73, hexagonIce, "inner", objHexagonUnbreakable);
			break;
		case 24:
			crackedChance = 0
			trampolineChance = 0
			arrowChance = 0
			wallChance = 0.05
			breakableChance = 0
			unbreakableChance = 0
			breakIceChance = 0; 
			solidIceChance = 0; 
			iceChance = 0
			fallChance = 1
			nothingChance = 0;  
			hologramSlowChance = 0;
			lowGravityChance = 0; 
			tileType = perlinLevelGeneration(0.39, posX, posY, floorNum, 30, 0.35, hexagonRandomFall, "inner");
			break;
		case 25:
			tileType = hexagonUnbreakable;
			break;
		case 26:
			crackedChance = 0
			trampolineChance = 0
			arrowChance = 0
			wallChance = 0.0
			breakableChance = 0
			unbreakableChance = 1
			breakIceChance = 0; 
			solidIceChance = 0; 
			iceChance = 0
			fallChance = 0
			nothingChance = 0;  
			hologramSlowChance = 0;
			lowGravityChance = 0; 
			tileType = perlinLevelGeneration(0, posX, posY, floorNum, 0, 0.2, hexagonUnbreakable, "outer", objHexagonHologramSlow, 0.1);
			break;
		case 27:
			crackedChance = 0.003
			trampolineChance = 0
			arrowChance = 0.0
			wallChance = 0
			breakableChance = 0
			unbreakableChance = 0
			breakIceChance = 0; 
			solidIceChance = 1; 
			iceChance = 0
			fallChance = 0
			nothingChance = 0;  
			hologramSlowChance = 0;
			lowGravityChance = 0; 
			tileType = perlinLevelGeneration(0, posX, posY, floorNum, 200, 0.2, hexagonBreakable, "outer", objHexagonHologramSlow, 0.1);
			break;
		case 28:
			crackedChance = 0
			trampolineChance = 0.0
			arrowChance = 0
			wallChance = 0
			breakableChance = 0
			unbreakableChance = 0
			breakIceChance = 0; 
			solidIceChance = 0; 
			iceChance = 0
			fallChance = 0
			nothingChance = 0; 
			hologramSlowChance = 1;
			lowGravityChance = 0; 
			tileType = perlinLevelGeneration(0.60, posX, posY, floorNum, 50, 0.01, hexagonIce, "inner", objHexagonSolidIce, +0.4);
			break;
		case 29:
			crackedChance = 0.005
			trampolineChance = 0.008
			arrowChance = 0
			wallChance = 0.005
			breakableChance = 0
			unbreakableChance = 0
			breakIceChance = 0; 
			solidIceChance = 0.2; 
			iceChance = 0
			fallChance = 1
			nothingChance = 0;  
			hologramSlowChance = 0;
			lowGravityChance = 0; 
			tileType = perlinLevelGeneration(0.33, posX, posY, floorNum, 55, 0.16, hexagonRandomFall, "half", objHexagonHologramSlow, +0.1);
			break;
		case 30:
			tileType = hexagonUnbreakable;
			break;
		case 31:
			crackedChance = 0
			trampolineChance = 0
			arrowChance = 0
			wallChance = 0
			breakableChance = 1
			unbreakableChance = 0
			breakIceChance = 0; 
			solidIceChance = 0; 
			iceChance = 0
			fallChance = 0
			nothingChance = 0;  
			hologramSlowChance = 0;
			lowGravityChance = 0; 
			tileType = perlinLevelGeneration(0.43, posX, posY, floorNum, 50, 0.2, hexagonBreakable, "inner", objHexagonSolidIce);
			break;
		case 32:
			crackedChance = 0
			trampolineChance = 0
			arrowChance = 0
			wallChance = 0
			breakableChance = 0
			unbreakableChance = 0
			breakIceChance = 0.1; 
			solidIceChance = 0; 
			iceChance = 0.15
			fallChance = 0
			nothingChance = 0;  
			hologramSlowChance = 0;
			lowGravityChance = 0; 
			tileType = perlinLevelGeneration(0.45, posX, posY, floorNum, 0, 0.1, hexagonBreakable, "inner", objHexagonSolidIce);
			break;
		case 33:
			crackedChance = 0
			trampolineChance = 0
			arrowChance = 0
			wallChance = 0
			breakableChance = 0
			unbreakableChance = 0
			breakIceChance = 0; 
			solidIceChance = 1; 
			iceChance = 0
			fallChance = 0
			nothingChance = 0; 
			hologramSlowChance = 0;
			lowGravityChance = 0; 
			tileType = perlinLevelGeneration(0.3, posX, posY, floorNum, 0, 0.78, hexagonIce, "half");
			break;
		case 34:
			crackedChance = 0
			trampolineChance = 0
			arrowChance = 0
			wallChance = 0
			breakableChance = 0
			unbreakableChance = 0
			breakIceChance = 0; 
			solidIceChance = 0; 
			iceChance = 0
			fallChance = 1
			nothingChance = 0;  
			hologramSlowChance = 0;
			lowGravityChance = 0; 
			tileType = perlinLevelGeneration(0.40, posX, posY, floorNum, 0, 0.35, hexagonRandomFall, "inner");
			break;
		case 35:
			tileType = hexagonUnbreakable;
			break;
		case 36:
			crackedChance = 0.002
			trampolineChance = 0
			arrowChance = 0
			wallChance = 0.03
			breakableChance = 0.12
			unbreakableChance = 1
			breakIceChance = 0; 
			solidIceChance = 0; 
			iceChance = 0
			fallChance = 0
			nothingChance = 0;  
			hologramSlowChance = 0;
			lowGravityChance = 0;
			tileType = perlinLevelGeneration(0.4, posX, posY, floorNum, 10, 0.1, hexagonUnbreakable, "outer", objHexagonHologramSlow);
			break;
		case 37:
			crackedChance = 0
			trampolineChance = 0
			arrowChance = 0
			wallChance = 0
			breakableChance = 1
			unbreakableChance = 0
			breakIceChance = 0; 
			solidIceChance = 0; 
			iceChance = 0
			fallChance = 0
			nothingChance = 0; 
			hologramSlowChance = 0;
			lowGravityChance = 0;
			tileType = perlinLevelGeneration(0.30, posX, posY, floorNum, 14, 0.64, hexagonBreakable, "half");
			break;
		case 38:
			crackedChance = 0
			trampolineChance = 0
			arrowChance = 0.7
			wallChance = 0.1
			breakableChance = 0
			unbreakableChance = 1
			breakIceChance = 0; 
			solidIceChance = 0; 
			iceChance = 0
			fallChance = 0
			nothingChance = 0;  
			hologramSlowChance = 0;
			lowGravityChance = 0; 
			tileType = perlinLevelGeneration(0.22, posX, posY, floorNum, 100, 0.66, hexagonIce, "inner");
			break;
		case 39:
			crackedChance = 0.002
			trampolineChance = 0
			arrowChance = 0
			wallChance = 0
			breakableChance = 0
			unbreakableChance = 0
			breakIceChance = 0; 
			solidIceChance = 0; 
			iceChance = 0
			fallChance = 0
			nothingChance = 0;  
			hologramSlowChance = 0;
			lowGravityChance = 1; 
			tileType = perlinLevelGeneration(0.48, posX, posY, floorNum, 0, 0.25, hexagonBreakable, "inner", objHexagonUnbreakable);
			break;
		case 40:
			tileType = hexagonUnbreakable;
			break;
		case 41:
			crackedChance = 0
			trampolineChance = 0
			arrowChance = 0
			wallChance = 0
			breakableChance = 0
			unbreakableChance = 0
			breakIceChance = 0; 
			solidIceChance = 0; 
			iceChance = 0
			fallChance = 0
			nothingChance = 0;  
			hologramSlowChance = 0;
			lowGravityChance = 1; 
			tileType = perlinLevelGeneration(0.25, posX, posY, floorNum, 5, 0.31, hexagonUnbreakable, "half");
			break;
		case 42:
			crackedChance = 0
			trampolineChance = 0
			arrowChance = 0.43
			wallChance = 0
			breakableChance = 0
			unbreakableChance = 0.3
			breakIceChance = 0; 
			solidIceChance = 0; 
			iceChance = 0
			fallChance = 0
			nothingChance = 0;  
			hologramSlowChance = 0;
			lowGravityChance = 0; 
			tileType = perlinLevelGeneration(0, posX, posY, floorNum, 2, 0.31, hexagonBreakable, "outer", objHexagonHologramSlow);
			break;
		case 43:
			crackedChance = 0
			trampolineChance = 0.015
			arrowChance = 0
			wallChance = 0.0
			breakableChance = 0
			unbreakableChance = 0
			breakIceChance = 0; 
			solidIceChance = 1; 
			iceChance = 0
			fallChance = 0
			nothingChance = 0;  
			hologramSlowChance = 0;
			lowGravityChance = 0; 
			tileType = perlinLevelGeneration(0.55, posX, posY, floorNum, 400, 0.05, hexagonIce, "inner");
			break;
		case 44:
			crackedChance = 0
			trampolineChance = 0
			arrowChance = 0.3
			wallChance = 0
			breakableChance = 0
			unbreakableChance = 0.5
			breakIceChance = 0; 
			solidIceChance = 0; 
			iceChance = 0
			fallChance = 0.5
			nothingChance = 0; 
			hologramSlowChance = 0;
			lowGravityChance = 0; 
			tileType = perlinLevelGeneration(0.35, posX, posY, floorNum, 15, 0.80, hexagonRandomFall, "half", objHexBreakable);
			break;
		case 45:
			tileType = hexagonUnbreakable;
			break;
		case 46:
			crackedChance = 0
			trampolineChance = 0
			arrowChance = 1
			wallChance = 0.2
			breakableChance = 0
			unbreakableChance = 1
			breakIceChance = 0; 
			solidIceChance = 0; 
			iceChance = 0
			fallChance = 0
			nothingChance = 0;  
			hologramSlowChance = 0;
			lowGravityChance = 0; 
			tileType = perlinLevelGeneration(0.30, posX, posY, floorNum, 0, 0.45, hexagonUnbreakable, "inner", objHexagonLowGravity);
			break;
		case 47:
			crackedChance = 0.0
			trampolineChance = 0.015
			arrowChance = 0
			wallChance = 0
			breakableChance = 0
			unbreakableChance = 1
			breakIceChance = 0; 
			solidIceChance = 0; 
			iceChance = 0
			fallChance = 0
			nothingChance = 0.09;  
			hologramSlowChance = 0;
			lowGravityChance = 0; 
			tileType = perlinLevelGeneration(0.3, posX, posY, floorNum, 2, 0.05, hexagonIce, "inner");
			break;
		case 48:
			crackedChance = 0
			trampolineChance = 0
			arrowChance = 0
			wallChance = 0
			breakableChance = 0
			unbreakableChance = 0
			breakIceChance = 0; 
			solidIceChance = 0; 
			iceChance = 1
			fallChance = 0
			nothingChance = 0;  
			hologramSlowChance = 0;
			lowGravityChance = 0; 
			tileType = perlinLevelGeneration(0.3, posX, posY, floorNum, 0, 0.59, hexagonIce, "half", objHexagonSolidIce);
			break;
		case 49:
			crackedChance = 0.01
			trampolineChance = 0
			arrowChance = 0
			wallChance = 0
			breakableChance = 0
			unbreakableChance = 0
			breakIceChance = 0; 
			solidIceChance = 0; 
			iceChance = 0
			fallChance = 1
			nothingChance = 0;  
			hologramSlowChance = 0;
			lowGravityChance = 0; 
			tileType = perlinLevelGeneration(0.6, posX, posY, floorNum, 100, 0.10, hexagonRandomFall, "outer", objHexagonLowGravity);
			break;
		case 50:
			tileType = hexagonUnbreakable;
			break;
		case 51:
			crackedChance = 0
			trampolineChance = 0
			arrowChance = 0
			wallChance = 0
			breakableChance = 0.25
			unbreakableChance = 1
			breakIceChance = 0; 
			solidIceChance = 0; 
			iceChance = 0
			fallChance = 0.25
			nothingChance = 0;  
			hologramSlowChance = 0;
			lowGravityChance = 0; 
			tileType = perlinLevelGeneration(0.57, posX, posY, floorNum, 0, 0.06, hexagonUnbreakable, "outer");
			break;
		case 52:
			crackedChance = 0
			trampolineChance = 0
			arrowChance = 0
			wallChance = 0
			breakableChance = 0
			unbreakableChance = 0
			breakIceChance = 0; 
			solidIceChance = 0; 
			iceChance = 0
			fallChance = 0.4
			nothingChance = 0;  
			hologramSlowChance = 0;
			lowGravityChance = 0; 
			tileType = perlinLevelGeneration(0.45, posX, posY, floorNum, 0, 0.35, hexagonBreakable, "half", objHexagonSolidIce);
			break;
		case 53:
			crackedChance = 0
			trampolineChance = 0
			arrowChance = 0
			wallChance = 0
			breakableChance = 1
			unbreakableChance = 0
			breakIceChance = 0; 
			solidIceChance = 0; 
			iceChance = 0
			fallChance = 0
			nothingChance = 0; 
			hologramSlowChance = 0;
			lowGravityChance = 0; 
			tileType = perlinLevelGeneration(0.42, posX, posY, floorNum, 0, 0.13, hexagonBreakable, "half");
			break;
		case 54:
			crackedChance = 0
			trampolineChance = 0
			arrowChance = 0.0
			wallChance = 0
			breakableChance = 0
			unbreakableChance = 0
			breakIceChance = 0; 
			solidIceChance = 0; 
			iceChance = 0
			fallChance = 0
			nothingChance = 0; 
			hologramSlowChance = 0;
			lowGravityChance = 1; 
			tileType = perlinLevelGeneration(0.4, posX, posY, floorNum, 10, 0.08, hexagonIce, "inner");
			break;
		case 55:
			tileType = hexagonUnbreakable;
			break;
		case 56:
			crackedChance = 0
			trampolineChance = 0.004
			arrowChance = 0
			wallChance = 0
			breakableChance = 0
			unbreakableChance = 0.15
			breakIceChance = 0; 
			solidIceChance = 0; 
			iceChance = 0
			fallChance = 1
			nothingChance = 0; 
			hologramSlowChance = 0;
			lowGravityChance = 0; 
			tileType = perlinLevelGeneration(0.55, posX, posY, floorNum, 0, 0.04, hexagonRandomFall, "half", objHexagonHologramSlow, 0.15);
			break;
		case 57:
			crackedChance = 0.0
			trampolineChance = 0.0
			arrowChance = 0.2
			wallChance = 0.05
			breakableChance = 0
			unbreakableChance = 0
			breakIceChance = 1; 
			solidIceChance = 0; 
			iceChance = 0
			fallChance = 0
			nothingChance = 0;  
			hologramSlowChance = 0;
			lowGravityChance = 0;
			tileType = perlinLevelGeneration(0.55, posX, posY, floorNum, 760, 0.1, hexagonBreakable, "half");
			break;
		case 58:
			crackedChance = 0
			trampolineChance = 0
			arrowChance = 0
			wallChance = 0
			breakableChance = 0
			unbreakableChance = 0
			breakIceChance = 0; 
			solidIceChance = 0; 
			iceChance = 1
			fallChance = 0
			nothingChance = 0;  
			hologramSlowChance = 0;
			lowGravityChance = 0; 
			tileType = perlinLevelGeneration(0.40, posX, posY, floorNum, 0, 0.2, hexagonIce, "inner", objHexagonUnbreakable, 0.15);
			break;
		case 59:
			crackedChance = 0.015
			trampolineChance = 0
			arrowChance = 0
			wallChance = 0
			breakableChance = 1
			unbreakableChance = 0
			breakIceChance = 0; 
			solidIceChance = 0; 
			iceChance = 0
			fallChance = 0
			nothingChance = 0;  
			hologramSlowChance = 0;
			lowGravityChance = 0; 
			tileType = perlinLevelGeneration(0.45, posX, posY, floorNum, 0, 0.58, hexagonBreakable, "inner");
			break;
		case 60:
			tileType = hexagonUnbreakable;
			break;
		case 61:
			crackedChance = 0
			trampolineChance = 0
			arrowChance = 0
			wallChance = 0
			breakableChance = 0
			unbreakableChance = 0
			breakIceChance = 0; 
			solidIceChance = 1; 
			iceChance = 0
			fallChance = 0
			nothingChance = 0;  
			hologramSlowChance = 0;
			lowGravityChance = 0; 
			tileType = perlinLevelGeneration(0.35, posX, posY, floorNum, 0, 0.4, hexagonUnbreakable, "outer", objHexagonHologramSlow);
			break;
		case 62:
			crackedChance = 0.0
			trampolineChance = 0
			arrowChance = 0
			wallChance = 0
			breakableChance = 0
			unbreakableChance = 0
			breakIceChance = 0; 
			solidIceChance = 0; 
			iceChance = 0
			fallChance = 0
			nothingChance = 0;  
			hologramSlowChance = 0;
			lowGravityChance = 1; 
			tileType = perlinLevelGeneration(0.60, posX, posY, floorNum, 800, 0.0002, hexagonBreakable, "outer");
			break;
		case 63:
			crackedChance = 0
			trampolineChance = 0
			arrowChance = 0
			wallChance = 0
			breakableChance = 0
			unbreakableChance = 0
			breakIceChance = 0; 
			solidIceChance = 0; 
			iceChance = 1
			fallChance = 0
			nothingChance = 0;  
			hologramSlowChance = 0;
			lowGravityChance = 0; 
			tileType = perlinLevelGeneration(0.5, posX, posY, floorNum, 1, 0.22, hexagonIce, "half");
			break;
		case 64:
			crackedChance = 0
			trampolineChance = 0
			arrowChance = 0.2
			wallChance = 0
			breakableChance = 0
			unbreakableChance = 0
			breakIceChance = 0; 
			solidIceChance = 0; 
			iceChance = 0
			fallChance = 0.9
			nothingChance = 0; 
			hologramSlowChance = 0;
			lowGravityChance = 0; 
			tileType = perlinLevelGeneration(0.43, posX, posY, floorNum, 0, 0.36, hexagonRandomFall, "inner");
			break;
		case 65:
			tileType = hexagonUnbreakable;
			break;
		case 66:
			crackedChance = 0
			trampolineChance = 0
			arrowChance = 0
			wallChance = 0.2
			breakableChance = 0
			unbreakableChance = 1
			breakIceChance = 0; 
			solidIceChance = 0; 
			iceChance = 0
			fallChance = 0
			nothingChance = 0; 
			hologramSlowChance = 0;
			lowGravityChance = 0; 
			tileType = perlinLevelGeneration(0.1, posX, posY, floorNum, 10, 0.32, hexagonUnbreakable, "outer", objHexagonHologramSlow, 0);
			break;
		case 67:
			crackedChance = 0.001
			trampolineChance = 0.003
			arrowChance = 0
			wallChance = 0.02
			breakableChance = 1
			unbreakableChance = 0
			breakIceChance = 0; 
			solidIceChance = 0; 
			iceChance = 0
			fallChance = 0.2
			nothingChance = 0; 
			hologramSlowChance = 0;
			lowGravityChance = 0;
			tileType = perlinLevelGeneration(0.51, posX, posY, floorNum, 0, 0.39, hexagonBreakable, "half");
			break;
		case 68:
			crackedChance = 0
			trampolineChance = 0
			arrowChance = 0
			wallChance = 0
			breakableChance = 0
			unbreakableChance = 0.8
			breakIceChance = 0; 
			solidIceChance = 0; 
			iceChance = 0
			fallChance = 0
			nothingChance = 0;  
			hologramSlowChance = 0;
			lowGravityChance = 0; 
			tileType = perlinLevelGeneration(0.66, posX, posY, floorNum, 0, 0.19, hexagonIce, "inner", objHexagonIce, 0.3);
			break;
		case 69:
			crackedChance = 0
			trampolineChance = 0
			arrowChance = 0
			wallChance = 0
			breakableChance = 0
			unbreakableChance = 0
			breakIceChance = 0; 
			solidIceChance = 0; 
			iceChance = 0
			fallChance = 1
			nothingChance = 0; 
			hologramSlowChance = 0;
			lowGravityChance = 0; 
			tileType = perlinLevelGeneration(0.6, posX, posY, floorNum, 300, 0.3, hexagonRandomFall, "inner", objHexagonLowGravity, 0.2);
			break;
		case 70:
			tileType = hexagonUnbreakable;
			break;
		case 71:
			crackedChance = 0
			trampolineChance = 0.01
			arrowChance = 0
			wallChance = 0
			breakableChance = 0
			unbreakableChance = 1
			breakIceChance = 0; 
			solidIceChance = 0; 
			iceChance = 0
			fallChance = 0
			nothingChance = 0; 
			hologramSlowChance = 0;
			lowGravityChance = 0; 
			tileType = perlinLevelGeneration(0.70, posX, posY, floorNum, 3, 0.17, hexagonUnbreakable, "half");
			break;
		case 72:
			crackedChance = 0
			trampolineChance = 0
			arrowChance = 0
			wallChance = 0
			breakableChance = 1
			unbreakableChance = 0
			breakIceChance = 0; 
			solidIceChance = 0; 
			iceChance = 0
			fallChance = 0
			nothingChance = 0; 
			hologramSlowChance = 0;
			lowGravityChance = 0; 
			tileType = perlinLevelGeneration(0.60, posX, posY, floorNum, 0, 0.15, hexagonBreakable, "outer");
			break;
		case 73:
			crackedChance = 0
			trampolineChance = 0.0
			arrowChance = 0
			wallChance = 0
			breakableChance = 0
			unbreakableChance = 0
			breakIceChance = 0; 
			solidIceChance = 0; 
			iceChance = 1
			fallChance = 0
			nothingChance = 0;
			hologramSlowChance = 0;
			lowGravityChance = 0; 
			tileType = perlinLevelGeneration(0.6, posX, posY, floorNum, 0, 0.22, hexagonIce, "half", objHexagonSolidIce);
			break;
		case 74:
			crackedChance = 0
			trampolineChance = 0.01
			arrowChance = 0
			wallChance = 0
			breakableChance = 0
			unbreakableChance = 1
			breakIceChance = 0; 
			solidIceChance = 0; 
			iceChance = 0
			fallChance = 0
			nothingChance = 0; 
			hologramSlowChance = 0;
			lowGravityChance = 0; 
			tileType = perlinLevelGeneration(0.71, posX, posY, floorNum, 540, 0.17, hexagonUnbreakable, "half");
			break;
		case 75:
			tileType = hexagonUnbreakable;
			break;
		case 76:
			crackedChance = 0.5
			trampolineChance = 0.01
			arrowChance = 0.75
			wallChance = 0.5
			breakableChance = 0.5
			unbreakableChance = 0.75
			breakIceChance = 0; 
			solidIceChance = 0; 
			iceChance = 0.2
			fallChance = 0.5
			nothingChance = 0; 
			hologramSlowChance = 0;
			lowGravityChance = 0; 
			tileType = perlinLevelGeneration(0.36, posX, posY, floorNum, 20, 0.24, hexagonUnbreakable, "inner");
			break;
		case 77:
			crackedChance = 0
			trampolineChance = 0
			arrowChance = 0
			wallChance = 0
			breakableChance = 1
			unbreakableChance = 0
			breakIceChance = 0; 
			solidIceChance = 0; 
			iceChance = 0
			fallChance = 0
			nothingChance = 0;  
			hologramSlowChance = 0.5;
			lowGravityChance = 0; 
			tileType = perlinLevelGeneration(0.4, posX, posY, floorNum, 0, 0.10, hexagonBreakable, "outer");
			break;
		case 78:
			crackedChance = 0
			trampolineChance = 0
			arrowChance = 0
			wallChance = 0
			breakableChance = 0
			unbreakableChance = 0
			breakIceChance = 0; 
			solidIceChance = 0; 
			iceChance = 1
			fallChance = 0
			nothingChance = 0; 
			hologramSlowChance = 0;
			lowGravityChance = 0;
			tileType = perlinLevelGeneration(0.5, posX, posY, floorNum, 0, 0.45, hexagonIce, "inner", objHexagonLowGravity, 0.2);
			break;
		case 79:
			crackedChance = 0
			trampolineChance = 0.005
			arrowChance = 0
			wallChance = 0.01
			breakableChance = 0
			unbreakableChance = 0
			breakIceChance = 0; 
			solidIceChance = 0; 
			iceChance = 0
			fallChance = 1
			nothingChance = 0; 
			hologramSlowChance = 0;
			lowGravityChance = 0; 
			tileType = perlinLevelGeneration(0.55, posX, posY, floorNum, 0, 0.42, hexagonRandomFall, "half");
			break;
		case 80:
			tileType = hexagonUnbreakable;
			break;
		case 81:
			crackedChance = 0
			trampolineChance = 0.04
			arrowChance = 0.
			wallChance = 0
			breakableChance = 1
			unbreakableChance = 1
			breakIceChance = 0; 
			solidIceChance = 0; 
			iceChance = 0
			fallChance = 0
			nothingChance = 0; 
			hologramSlowChance = 0;
			lowGravityChance = 0; 
			tileType = perlinLevelGeneration(0.65, posX, posY, floorNum, 0, 0.31, hexagonBreakable, "outer");
			break;
		case 82:
			crackedChance = 0.05
			trampolineChance = 0
			arrowChance = 0
			wallChance = 0.1
			breakableChance = 1
			unbreakableChance = 0.4
			breakIceChance = 0; 
			solidIceChance = 0; 
			iceChance = 0
			fallChance = 0
			nothingChance = 0;  
			hologramSlowChance = 0;
			lowGravityChance = 0; 
			tileType = perlinLevelGeneration(0.54, posX, posY, floorNum, 0, 0.09, hexagonBreakable, "inner");
			break;
		case 83:
			crackedChance = 0
			trampolineChance = 0
			arrowChance = 0
			wallChance = 0.05
			breakableChance = 0
			unbreakableChance = 0
			breakIceChance = 0; 
			solidIceChance = 0; 
			iceChance = 1
			fallChance = 0
			nothingChance = 0;  
			hologramSlowChance = 0;
			lowGravityChance = 0;
			tileType = perlinLevelGeneration(0.3, posX, posY, floorNum, 15, 0.66, hexagonIce, "half", objHexagonHologramSlow);
			break;
		case 84:
			crackedChance = 0
			trampolineChance = 0
			arrowChance = 0
			wallChance = 0
			breakableChance = 0
			unbreakableChance = 0
			breakIceChance = 0; 
			solidIceChance = 0; 
			iceChance = 0
			fallChance = 1
			nothingChance = 0; 
			hologramSlowChance = 0;
			lowGravityChance = 0; 
			tileType = perlinLevelGeneration(0.64, posX, posY, floorNum, 70, 0.35, hexagonRandomFall, "inner");
			break;
		case 85:
			tileType = hexagonUnbreakable;
			break;
		case 86:
			crackedChance = 0.05
			trampolineChance = 0
			arrowChance = 0
			wallChance = 0
			breakableChance = 0.2
			unbreakableChance = 1
			breakIceChance = 0; 
			solidIceChance = 0; 
			iceChance = 0
			fallChance = 0
			nothingChance = 0; 
			hologramSlowChance = 0;
			lowGravityChance = 0; 
			tileType = perlinLevelGeneration(0.53, posX, posY, floorNum, 0, 0.34, hexagonUnbreakable, "inner", objHexagonLowGravity, 0.2);
			break;
		case 87:
			crackedChance = 0
			trampolineChance = 0
			arrowChance = 0.2
			wallChance = 0
			breakableChance = 0
			unbreakableChance = 0.1
			breakIceChance = 1; 
			solidIceChance = 0; 
			iceChance = 0
			fallChance = 0
			nothingChance = 0;  
			hologramSlowChance = 0;
			lowGravityChance = 0.1; 
			tileType = perlinLevelGeneration(0.63, posX, posY, floorNum, 0, 0.50, hexagonBreakable, "half");
			break;
		case 88:
			crackedChance = 0
			trampolineChance = 0.005
			arrowChance = 0
			wallChance = 0
			breakableChance = 0
			unbreakableChance = 0
			breakIceChance = 0; 
			solidIceChance = 0; 
			iceChance = 1
			fallChance = 0
			nothingChance = 0;  
			hologramSlowChance = 0;
			lowGravityChance = 0; 
			tileType = perlinLevelGeneration(0.55, posX, posY, floorNum, 236, 0.55, hexagonIce, "half");
			break;
		case 89:
			crackedChance = 0
			trampolineChance = 0
			arrowChance = 0
			wallChance = 0
			breakableChance = 0
			unbreakableChance = 0
			breakIceChance = 0; 
			solidIceChance = 0; 
			iceChance = 0.8
			fallChance = 1
			nothingChance = 0; 
			hologramSlowChance = 0;
			lowGravityChance = 0; 
			tileType = perlinLevelGeneration(0.49, posX, posY, floorNum, 0.5, 0.13, hexagonRandomFall, "inner", objHexagonHologramSlow, 0.2);
			break;
		case 90:
			tileType = hexagonUnbreakable;
			break;
		case 91:
			crackedChance = 0.02
			trampolineChance = 0.075
			arrowChance = 0
			wallChance = 0
			breakableChance = 1
			unbreakableChance = 0.2
			breakIceChance = 0; 
			solidIceChance = 0; 
			iceChance = 0
			fallChance = 0
			nothingChance = 0;  
			hologramSlowChance = 0;
			lowGravityChance = 0; 
			tileType = perlinLevelGeneration(0.66, posX, posY, floorNum, 1320, 0.27, hexagonBreakable, "outer");
			break;
		case 92:
			crackedChance = 1
			trampolineChance = 0
			arrowChance = 0
			wallChance = 0
			breakableChance = 1
			unbreakableChance = 0
			breakIceChance = 0; 
			solidIceChance = 0; 
			iceChance = 0
			fallChance = 0
			nothingChance = 0;  
			hologramSlowChance = 0;
			lowGravityChance = 0; 
			tileType = perlinLevelGeneration(0.43, posX, posY, floorNum, 0, 0.17, hexagonBreakable, "inner", objHexBreakable, 0.1);
			break;
		case 93:
			crackedChance = 0
			trampolineChance = 0
			arrowChance = 0
			wallChance = 0
			breakableChance = 0.25
			unbreakableChance = 0
			breakIceChance = 0; 
			solidIceChance = 0; 
			iceChance = 1
			fallChance = 0
			nothingChance = 0;  
			hologramSlowChance = 0;
			lowGravityChance = 0; 
			tileType = perlinLevelGeneration(0.57, posX, posY, floorNum, 10, 0.48, hexagonIce, "half");
			break;
		case 94:
			crackedChance = 0
			trampolineChance = 0
			arrowChance = 0
			wallChance = 0
			breakableChance = 0
			unbreakableChance = 0
			breakIceChance = 0; 
			solidIceChance = 0; 
			iceChance = 0
			fallChance = 0
			nothingChance = 0;  
			hologramSlowChance = 1;
			lowGravityChance = 0; 
			tileType = perlinLevelGeneration(0.5, posX, posY, floorNum, 0, 0.05, hexagonRandomFall, "inner", objHexagonLowGravity, 0.2);
			break;
		case 95:
			tileType = hexagonUnbreakable;
			break;
		case 96:
			crackedChance = 0.5
			trampolineChance = 0.5
			arrowChance = 1
			wallChance = 0.5
			breakableChance = 1
			unbreakableChance = 1
			breakIceChance = 0; 
			solidIceChance = 1; 
			iceChance = 1
			fallChance = 1
			nothingChance = 0;  
			hologramSlowChance = 0.75;
			lowGravityChance = 0.3; 
			tileType = perlinLevelGeneration(0.58, posX, posY, floorNum, 226, 0.35, hexagonIce, "half");
			break;
		case 97:
			crackedChance = 0
			trampolineChance = 0
			arrowChance = 0
			wallChance = 0.
			breakableChance = 0
			unbreakableChance = 0
			breakIceChance = 0; 
			solidIceChance = 0; 
			iceChance = 0
			fallChance = 1
			nothingChance = 0;  
			hologramSlowChance = 0;
			lowGravityChance = 0; 
			tileType = perlinLevelGeneration(0, posX, posY, floorNum, 1090, 0.15, hexagonIce, "outer");
			break;
		case 98:
			crackedChance = 0.6
			trampolineChance = 0.5
			arrowChance = 1
			wallChance = 0.5
			breakableChance = 1
			unbreakableChance = 1
			breakIceChance = 1; 
			solidIceChance = 0; 
			iceChance = 1
			fallChance = 1
			nothingChance = 0;  
			hologramSlowChance = 0.75;
			lowGravityChance = 0.3; 
			tileType = perlinLevelGeneration(0.50, posX, posY, floorNum, 226, 0.35, hexagonIce, "half");
			break;
		case 99:
			crackedChance = 0.6
			trampolineChance = 0.5
			arrowChance = 1
			wallChance = 0.5
			breakableChance = 1
			unbreakableChance = 1
			breakIceChance = 0; 
			solidIceChance = 1; 
			iceChance = 1
			fallChance = 1
			nothingChance = 0;  
			hologramSlowChance = 0.75;
			lowGravityChance = 0.3; 
			tileType = perlinLevelGeneration(0.58, posX, posY, floorNum, 2496, 0.35, hexagonIce, "half");
			break;
		case 100:
			tileType = hexagonUnbreakable;
			break;	
	}

	return tileType;
}

// @desc difficulty is a value between 0 and 1, where 0 is easy and 1 is hard
// posX and posY are the coordinates of the tile
// floorNum is the current floor number
// seed is a random seed value
// frequency is a value between 0 and 1, where 0 is low frequency and 1 is high frequency
function perlinLevelGeneration(difficulty, posX, posY, floorNum, seed, frequency, baseLevelTile, generationType, overrideTile, offset = 0) {
    random_set_seed(floorNum + seed + posX + posY);

    var adjustedDifficulty = adjustDifficulty(difficulty);
    var adjustedFrequency = adjustFrequency(frequency);

    var noiseValue = perlin_noise((posX + seed) * adjustedFrequency, (posY + seed) * adjustedFrequency, floorNum * 321);

    var generated = false;
    if (generationType == "inner") {
        generated = noiseValue > 0 + ((adjustedDifficulty * 2) - 1);
    } else if (generationType == "outer") {
        generated = noiseValue < 0 - difficulty * difficulty * difficulty || noiseValue > difficulty * difficulty * difficulty;
    } else if (generationType == "half") {
        generated = noiseValue > -1 + adjustedDifficulty * 2;
    }

    if (generated) {
	    // Determine if overrideTile should be applied based on Perlin noise value and generationType
	    var shouldOverride = false;

	    if (generationType == "inner") {
	        // For "inner", override tiles in the upper half of the noise range
	        shouldOverride = noiseValue > 0 + offset;
	    } else if (generationType == "outer") {
	        // For "outer", override tiles in the outer 50% of the noise range
	        shouldOverride = noiseValue > 0 + offset;
	    } else if (generationType == "half") {
	        // For "half", override tiles in the upper half of the noise range
	        shouldOverride = noiseValue > 0.25 + offset;
	    }

	    // If overrideTile is provided and shouldOverride is true, return overrideTile
	    if (overrideTile && shouldOverride) {
	        return overrideTile;
	    }

	    // Rest of the tile generation logic remains unchanged
	    var totalChance = crackedChance + trampolineChance + arrowChance + wallChance + breakableChance + unbreakableChance + iceChance + solidIceChance + fallChance + breakIceChance + nothingChance + hologramSlowChance + lowGravityChance;

	    var randomChoice = random(totalChance);
	    var cumulativeChance = 0;

	    // Check for nothingChance
	    cumulativeChance += nothingChance;
	    if (randomChoice < cumulativeChance) return noone;

	    // Select the tile type based on cumulative chances
	    cumulativeChance += crackedChance;
	    if (randomChoice < cumulativeChance) return hexagonDeadly;

	    cumulativeChance += trampolineChance;
	    if (randomChoice < cumulativeChance) return hexagonJump;

	    cumulativeChance += arrowChance;
	    if (randomChoice < cumulativeChance) return hexagonArrow;

	    cumulativeChance += wallChance;
	    if (randomChoice < cumulativeChance) return hexagonWall;

	    cumulativeChance += breakableChance;
	    if (randomChoice < cumulativeChance) return hexagonBreakable;

	    cumulativeChance += unbreakableChance;
	    if (randomChoice < cumulativeChance) return hexagonUnbreakable;

	    cumulativeChance += iceChance;
	    if (randomChoice < cumulativeChance) return hexagonIce;

	    cumulativeChance += solidIceChance;
	    if (randomChoice < cumulativeChance) return hexagonSolidIce;

	    cumulativeChance += fallChance;
	    if (randomChoice < cumulativeChance) return hexagonRandomFall;

	    cumulativeChance += breakIceChance;
	    if (randomChoice < cumulativeChance) return objHexagonBreakIce;

	    cumulativeChance += hologramSlowChance;
	    if (randomChoice < cumulativeChance) return objHexagonHologramSlow;

	    cumulativeChance += lowGravityChance;
	    if (randomChoice < cumulativeChance) return objHexagonLowGravity;

	    // Default tile if none selected
	    return baseLevelTile;
	} else {
	    return noone;
	}
}


// @desc difficulty is a value between 0 and 1, where 0 is easy and 1 is hard
// posX and posY are the coordinates of the tile
// floorNum is the current floor number
// seed is a random seed value
function randomLevelGeneration(difficulty, posX, posY, floorNum, seed, baseLevelTile, overrideTile) {
    random_set_seed(floorNum + seed + posX + posY);

    // Generate a random number between 0 and 1
    var noiseValue = random(1);

    if (noiseValue > difficulty) {
        // If overrideTile is provided and valid, return it for 50% of the random pattern
        if (overrideTile && noiseValue > 0.5) {
            return overrideTile;
        }

        // Calculate total chance for enabled tile types
        var totalChance = crackedChance + trampolineChance + arrowChance + wallChance + breakableChance + unbreakableChance + iceChance + solidIceChance + fallChance + breakIceChance + hologramSlowChance + lowGravityChance;

        // Generate a random number between 0 and the total chance
        var randomChoice = random(totalChance);
        var cumulativeChance = 0;

        // Select the tile type based on cumulative chances
        cumulativeChance += crackedChance;
        if (randomChoice < cumulativeChance) return hexagonDeadly;

        cumulativeChance += trampolineChance;
        if (randomChoice < cumulativeChance) return hexagonJump;

        cumulativeChance += arrowChance;
        if (randomChoice < cumulativeChance) return hexagonArrow;

        cumulativeChance += wallChance;
        if (randomChoice < cumulativeChance) return hexagonWall;

        cumulativeChance += breakableChance;
        if (randomChoice < cumulativeChance) return hexagonBreakable;

        cumulativeChance += unbreakableChance;
        if (randomChoice < cumulativeChance) return hexagonUnbreakable;

        cumulativeChance += iceChance;
        if (randomChoice < cumulativeChance) return hexagonIce;

        cumulativeChance += solidIceChance;
        if (randomChoice < cumulativeChance) return hexagonSolidIce;

        cumulativeChance += fallChance;
        if (randomChoice < cumulativeChance) return hexagonRandomFall;

        cumulativeChance += breakIceChance;
        if (randomChoice < cumulativeChance) return objHexagonBreakIce;

        cumulativeChance += hologramSlowChance;
        if (randomChoice < cumulativeChance) return objHexagonHologramSlow;

        cumulativeChance += lowGravityChance;
        if (randomChoice < cumulativeChance) return objHexagonLowGravity;

        // Default tile if none selected
        return baseLevelTile;
    } else {
        return noone;
    }
}

function adjustDifficulty(difficulty) {

	k = 0.5

    // Ensure k is a positive number to avoid division by zero and incorrect results
    if (k <= 0) {
        k = 1; // default to 1 if an invalid value is provided
    }

    // Apply the custom sigmoid-like function with steepness factor k
    var adjustedDifficulty = power(difficulty, k) / (power(difficulty, k) + power(1 - difficulty, k));
    return adjustedDifficulty;
}

function adjustFrequency(frequency) {
    return lerp(0.008, 0.025, frequency);
}

function destroyTileLayer(floorNum) {
    with (objParentHexagon) { 
        if (floorNumber > floorNum) {
            instance_destroy();
        }
    }
}
