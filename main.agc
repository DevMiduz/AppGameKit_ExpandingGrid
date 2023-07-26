/*
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

/*
*	main.agc
* 	CREATED BY: DEV MIDUZ
*	https://github.com/DevMiduz/AppGameKit_ExpandingGrid
*	devmiduz@gmail.com
*/

/*

	INCLUDES

*/

#include "includes.agc"

/*

	CONSTANTS

*/

/*

	MAIN PROGRAM

*/

InitEngine()

grid as EXG_Grid
EXG_InitGridRef(grid, 8)
position as EXG_Point
changed as integer

do
	changed = -1 
	
    Print( ScreenFPS() )
    point as EXG_Point
    
    if(GetRawKeyPressed(37))	
    		dec position.x
    		
    		point = EXG_GetTilePointFromPosition(grid, position)
    		changed = 1
   	endif
   	
    if(GetRawKeyPressed(38))	
    		dec position.y
    		
    		point = EXG_GetTilePointFromPosition(grid, position)
    		changed = 1
   	endif
   	
    if(GetRawKeyPressed(39))	
    		inc position.x
    		
    		point = EXG_GetTilePointFromPosition(grid, position)
    		changed = 1
   	endif
   	
    if(GetRawKeyPressed(40))	
    		inc position.y
    		
    		point = EXG_GetTilePointFromPosition(grid, position)
    		changed = 1
   	endif
   	
   	Print("POSITION: " + str(position.x) + "," + str(position.y))
   	Print("POINT: " + str(point.x) + "," + str(point.y))
   	Print("POINT IS WITHIN GRID: " + str(EXG_IsPointWithinGrid(grid, point)))
   	
   	centerPoint as EXG_Point
   	centerPoint = EXG_GetTileCenterByPoint(grid, point)
   	Print("POINT CENTER IS: X:" + str(centerPoint.x) + ", Y: " + str(centerPoint.y))
   	
   	box as EXG_Box
   	box.position.x = -16
   	box.position.y = -16
   	box.size = 30
   	
   	test = EXG_GetTileIndexesInBox(grid, box)
    Print(str(test))
    
    if(GetRawKeyPressed(32))
    		EXG_ExpandGrid(grid, 1, 1, 1, 1)
    		EXG_DebugGrid(grid)
   	endif
    
    
    Sync()
loop
