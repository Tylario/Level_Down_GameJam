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

			if (layer > 13)
			{
				var tileType = objHexagonWall
			}
			else
			{
				var tileType = determineTileType(floorNum, posX, posY);
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
    if (posX == trampolineX && posY == trampolineY) {
        return hexagonTrampoline;
    }
	
	if (floorNum % 5 == 0) 
	{
	    return hexagonUnbreakable;
	}

	//Level design / Tile Generation Starts here
	
	switch (floorNum) {
		case 0: 
			tileType = objHexagonUnbreakable
			break;
		case 1:
			tileType = randomLevelGeneration(0.5, posX, posY, floorNum, 0);
			break;
		case 2:
			tileType = perlinLevelGeneration(0.5, posX, posY, floorNum, 0, 0.33);	
			break;
		case 3:
			tileType = perlinLevelGeneration(0.5, posX, posY, floorNum, 0, 0.66);
			break;
		case 4:
			tileType = perlinLevelGeneration(0.5, posX, posY, floorNum, 0, 1);
			break;
		case 5:
			tileType = objHexagonUnbreakable
			break;
		case 6:
			tileType = perlinLevelGeneration(0.4, posX, posY, floorNum, 0, 0.25);	
			break;
		case 7:
			tileType = perlinLevelGeneration(0.4, posX, posY, floorNum, 0, 0.25);	
			break;
		case 8:
			tileType = perlinLevelGeneration(0.4, posX, posY, floorNum, 0, 0.25);	
			break;
		case 9:
			tileType = perlinLevelGeneration(0.4, posX, posY, floorNum, 0, 0.25);	
			break;
		case 10:
			tileType = objHexagonUnbreakable
			break;
		case 11:
			tileType = perlinLevelGeneration(0.4, posX, posY, floorNum, 0, 0.25);	
			break;
		case 12:
			tileType = perlinLevelGeneration(0.4, posX, posY, floorNum, 0, 0.25);	
			break;
		case 13:
			tileType = perlinLevelGeneration(0.4, posX, posY, floorNum, 0, 0.25);	
			break;
		default:
			tileType = objHexagonArrow
	}

	return tileType;
}

// @desc difficulty is a value between 0 and 1, where 0 is easy and 1 is hard
// posX and posY are the coordinates of the tile
// floorNum is the current floor number
// seed is a random seed value
// frequency is a value between 0 and 1, where 0 is low frequency and 1 is high frequency
function perlinLevelGeneration (difficulty, posX, posY, floorNum, seed, frequency)
{
	random_set_seed(floorNum + seed);

	var adjustedDifficulty = adjustDifficulty(difficulty);
	var adjustedFrequency = adjustFrequency(frequency);

	var noiseValue = perlin_noise(posX * adjustedFrequency, posY * adjustedFrequency, floorNum * 321); // between -1 and 1, with normal distribution around 0

	if (noiseValue > -1 + adjustedDifficulty * 2) 
	{
		return objHexagonUnbreakable;
	}
	else
	{
		return noone;
	}
}

// @desc difficulty is a value between 0 and 1, where 0 is easy and 1 is hard
// posX and posY are the coordinates of the tile
// floorNum is the current floor number
// seed is a random seed value
function randomLevelGeneration (difficulty, posX, posY, floorNum, seed)
{
	random_set_seed(floorNum + seed + posX + posY);


	var noiseValue = random(1)

	if (noiseValue > difficulty) 
	{
		return objHexagonUnbreakable;
	}
	else
	{
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

