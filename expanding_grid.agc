/*
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

/*
*	expanding_grid.agc
* 	CREATED BY: DEV MIDUZ
*	https://github.com/DevMiduz/AppGameKit_ExpandingGrid
*	devmiduz@gmail.com
*/

/*

	INCLUDES

*/

/*

	CONSTANTS

*/

/*

	TYPES
		
*/

type EXG_Box
	position as EXG_Point // top-left
	size as integer
endtype

type EXG_Point
	x as integer
	y as integer
endtype

type EXG_Tile
	index as integer
endtype

type EXG_Row
	index as integer
	tiles as EXG_Tile[]
endtype

type EXG_Grid
	northOffset as integer
	eastOffset as integer
	southOffset as integer
	westOffset as integer
	
	center as EXG_Point
	tileSize as integer
	rows as EXG_Row[]
endtype

/*
	
	FUNCTIONS
	
*/


function EXG_InitGridRef(grid ref as EXG_Grid, tileSize as integer)
	grid.tileSize = tileSize
	grid.rows.length = 0
	grid.rows[0].tiles.length = 0
endfunction grid

function EXG_DebugGrid(grid ref as EXG_Grid)
	output as String
	position as EXG_Point
	
	for i = 0 to grid.rows.length	
		output = str(grid.rows[i].index) + " => "
		
		for j = 0 to grid.rows[i].tiles.length
			
			position = EXG_GetTileWorldPosition(grid, grid.rows[i].index, grid.rows[i].tiles[j].index)
			output = output + "| x:" + str(position.x) + ", y:" + str(position.y) + " |"
			//output = output + "| " + str(grid.rows[i].tiles[j].index) + " |"
		next j
		
		Log(output)
	next i
endfunction

function EXG_ExpandGrid(grid ref as EXG_Grid, north as integer, east as integer, south as integer, west as integer)
	newRow as EXG_Row
	newTile as EXG_Tile
	newPosition as EXG_Point
		
	newRow.tiles.length = grid.westOffset + grid.eastOffset
	
	for tileIndex = 0 to newRow.tiles.length
		newTile.index = (tileIndex - grid.westOffset)		
		newRow.tiles[tileIndex] = newTile
	next tileIndex
	
	if north > 0 		
		for rowIndex = 1 to north 
			inc grid.northOffset
			newRow.index = -grid.northOffset
			grid.rows.insert(newRow, 0)
		next rowIndex
	endif
	
	if south > 0 	
		for rowIndex = 1 to south 
			inc grid.southOffset
			newRow.index = grid.southOffset
			grid.rows.insert(newRow)
		next rowIndex
	endif
	
	if west > 0 
		for rowIndex = 0 to grid.rows.length
			for tileIndex = 1 to west 
				newTile.index = -(grid.westOffset + tileIndex)
				grid.rows[rowIndex].tiles.insert(newTile, 0)
			next tileIndex
			
		next rowIndex
		
		inc grid.westOffset, west
	endif
		
	if east > 0 
		for rowIndex = 0 to grid.rows.length
			for tileIndex = 1 to east 
				newTile.index = (grid.eastOffset + tileIndex)
				grid.rows[rowIndex].tiles.insert(newTile)
			next tileIndex
			
		next rowIndex
		
		inc grid.eastOffset, east
	endif
	
endfunction

function EXG_CreatePoint(x as integer, y as integer)
	point as EXG_Point
	point.x = x
	point.y = y
endfunction point

function EXG_SetPoint(point ref as EXG_Point, x as integer, y as integer)
	point.x = x
	point.y = y
endfunction	 

function EXG_GetActualRowIndex(grid ref as EXG_Grid, index as integer)
endfunction index + grid.northOffset

function EXG_GetActualTileIndex(grid ref as EXG_Grid, index as integer)
endfunction index + grid.westOffset

function EXG_GetTilePointFromPosition(grid ref as EXG_Grid, position as EXG_Point)
	tilePoint as EXG_Point
	
	if(position.x < 0)
		tilePoint.x = ((position.x - (grid.tileSize - 1))  / grid.tileSize)
	else
		tilePoint.x = ((position.x)  / grid.tileSize)
	endif
	
	if(position.y < 0)
		tilePoint.y = ((position.y - (grid.tileSize - 1)) / grid.tileSize)
	else
		tilePoint.y = ((position.y) / grid.tileSize)
	endif
endfunction tilePoint

function EXG_GetTileWorldPosition(grid ref as EXG_Grid, x as integer, y as integer)
	position as EXG_Point
	position = EXG_CreatePoint(grid.center.x + (x * grid.tileSize), grid.center.y + (y * grid.tileSize))
endfunction position

function EXG_IsPointWithinGrid(grid ref as EXG_Grid, point as EXG_Point)
	if(point.x < -Grid.westOffset or point.x > Grid.eastOffset) then exitfunction -1
	if(point.y < -Grid.northOffset or point.y > Grid.southOffset) then exitfunction -1
endfunction 1

function EXG_GetTileCenterByPoint(grid ref as EXG_Grid, point as EXG_Point)
	position as EXG_Point
	position = EXG_GetTileCenterByIndex(grid, point.x, point.y)
endfunction position

function EXG_GetTileCenterByIndex(grid ref as EXG_Grid, x as integer, y as integer)
	position as EXG_Point
	position = EXG_CreatePoint(grid.center.x + (x * grid.tileSize) + (grid.tileSize / 2), grid.center.y + (y * grid.tileSize) + (grid.tileSize / 2) )
endfunction position

function EXG_GetTileIndexesInBox(grid ref as EXG_Grid, box as EXG_Box)
	tileIndexes as EXG_Point[]
	
	indexSize as integer 
	indexSize = box.size / grid.tileSize
	
	if(mod(box.size, grid.tileSize) <> 0)
		inc indexSize
	endif
	
	position as EXG_Point
	
	for i = 0 to indexSize - 1
		
		position.x = box.position.x + (grid.tileSize * i) 
			
		for j = 0 to indexSize - 1

			position.y = box.position.y + (grid.tileSize * j)
			
			tileIndexes.insert(EXG_GetTilePointFromPosition(grid, position))
		next j
	next i
	
	for i = 0 to tileIndexes.length
		Log(str(tileIndexes[i].x) + "," + str(tileIndexes[i].y))
	next i
	
endfunction indexSize